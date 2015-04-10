class MembershipsController < ApplicationController
  respond_to :json

  def create
    @membership = Membership.where(
      person_email: membership_params[:person_attributes][:email],
      list_id: membership_params[:list_id]
    ).first_or_initialize

    @membership.attributes = membership_params

    if @membership.save
      redirect_to list_membership_path(@membership.list, @membership), success: "List was created"
    else
      respond_with(@membership)
    end
  end

  def destroy
    @membership = Membership.find(params[:id])

    @membership.destroy

    respond_with(@membership)
  end

  def show
    @membership = Membership.find(params[:id])
  end

  def edit
    @membership.notes.build
  end

  private

  def membership_params
    params.require(:membership).permit(:list_id, :person_attributes => [:name, :email], :notes_attributes => [:content])
  end
end
