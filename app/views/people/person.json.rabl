attributes :name, :email, :id

node(:notes) do |person|
  person.notes.map(&:content)
end
