class ListsController < ApplicationController
  before_action :find_list, only: [:show, :edit, :update, :destroy]

  def new
    @list = List.new
  end

  def create
    @list = List.new list_params

    if @list.save
      redirect_to list_path(@list), success: "List was created"
    else
      flash[:errors] = @list.errors.full_messages.to_sentence
      render :new
    end
  end

  def index
    @lists = List.all
  end

  def edit
    @membership = Membership.new
    @membership.person = Person.new
    @membership.notes.build
  end

  private

  def find_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description)
  end
end
