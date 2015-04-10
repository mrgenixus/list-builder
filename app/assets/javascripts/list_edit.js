$(function() {

  function humanize(str) {
    return str
      .replace(/[\._]/, " ")
      .replace(/\b(\w)/,function(match) {
        return match.toUpperCase();
      });
  }

  $(document).on('submit', '.list.edit form', cleanup);

  $(document).on('ajax:error', '.list.edit form', function(event, data) {
    var $errors = $(this).find('.errors'),
      error_lines = $();

    $.each(data.responseJSON.errors, function(field, errors) {
      var field_name = humanize(field.replace(/person[^\w]+(.+)/, "$1")),
        error_text = errors.join(", "),
        $list_item = $('<li>').html([field_name, error_text].join(' '));

      error_lines = error_lines.add($list_item);
    });

    var list = error_lines.wrap('<ul>');
    $errors.append(list);
  });

  $(document).on('ajax:success', '.list.edit form', function(xhr, data) {
    var $table = $("table.people");

    if($table.length === 0) {
      document.location.reload();
    }
    $template = $table.find('.template');

    var existing_entries = $table
      .find('td.email')
        .filter(function() { return $(this).text().match(data.membership.email); });

    if (existing_entries.length === 0) {

      $template.clone()
        .removeClass('uk-hidden template')
        .attr('data-id', data.membership.id)
        .find('.name')
          .html(data.membership.name)
        .end()
        .find('.email')
          .html(data.membership.email)
        .end()
        .find('.actions [href$="memberships/0.json"]')
          .attr('href', function(idx, href) {
            return href.replace(/memberships\/0\.json$/, "memberships/" + data.membership.id + ".json");
          })
        .end()
        .find('.actions [href$="people/0/edit"]')
          .attr('href', function(idx, href) {
            return href.replace(/people\/0\/edit$/, "people/" + data.membership.person.id + "/edit");
          })
        .end()
        .appendTo($table);
    } else {
      existing_entries.each(function() {
        $(this).parent().addClass('uk-form-success');
        _.delay(function(el) {
          $(el).parent().removeClass('uk-form-success');
        }, 1e3, this);

      });
    }

    reset.call(this);
  });

  function cleanup() {
    $(this).find('.errors').empty();
    $(this).find('div.notes').remove();
  }

  function reset() {
    this.reset();
    $(this.elements).filter(':visible').first().focus();
    $(this).find('[type=submit]').val('Add Person');
    cleanup.call(this);
  }

  $(document).on('reset', '.list.edit form', reset);

  $('.list.edit').on('click', '.membership-delete', function(event) {
    $(event.target).parent().parent().fadeOut("fast", function() {
      $(this).remove();
    });
  });

  $(document).on('click', '.list.edit [data-id] .person-edit', function(e) {
    e.preventDefault();
    var list_id = $('.list').data('id');
    var membership_id = $(this).closest('[data-id]').data('id');
    $.get('/lists/' + list_id + '/memberships/' + membership_id + '.json', function(data) {
      var form = $('.list.edit form');
      form[0].reset();
      form.find('[name="membership[person_attributes][email]"]').val(data.membership.email);
      form.find('[name="membership[person_attributes][name]"]').val(data.membership.name);
      var notes = $('<div class="notes">').append($('<p>').html($.map(data.membership.notes.split("\n"), function(note, idx) {
        return $('<blockquote>').html(note);
      }))).prepend($("<h3>").html("Notes:"));
      form.find('[name="membership[notes_attributes][0][content]"]').focus().parent().before(notes);
      form.find('[type=submit]').val('Update Person');
    });
  });
});
