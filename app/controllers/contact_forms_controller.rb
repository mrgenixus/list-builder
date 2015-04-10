class ContactFormsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user!

  before_filter :allow_cors

  layout "thank_you", only: :thank_you

  def create
     @membership = Membership.where(
      person_email: membership_params[:person_attributes][:email],
      list_id: membership_params[:list_id]
    ).first_or_initialize

    @membership.attributes = membership_params

    if @membership.save
      redirect_to sign_up_thank_you_path(@membership.list), success: "List was created"
    else
      respond_with(@membership)
    end
  end

  def thank_you
    @list = List.find(params[:id])

    if @list.try(:thank_you_url).present?
      redirect_to @list.thank_you_url and return
    elsif @list.try(:thank_you_message).present?
      render :thank_you_message and return
    end
  end

  private

  def allow_cors
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
    headers["Access-Control-Allow-Headers"] =
      %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")

    render text: '' if request.request_method == "OPTIONS"
  end

  def membership_params
    params.require(:membership).permit(:list_id, :person_attributes => [:name, :email], :notes_attributes => [:content])
  end
end
