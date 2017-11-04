class PhotosController < ApplicationController

  before_action :set_photo, only: [:show, :edit, :update, :destroy, :to_public]

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photos_url
    else
      render  :action => :new
    end
  end
 
  def show
  end

  def edit
  end


  def update
    if @photo.update_attributes(photo_params)
      redirect_to photos_path(@photo)
    else
      render  :action => :edit
    end
  end

  def destroy
    if DateTime.current < Photo.find(params[:id]).date
      @photo.destroy
      redirect_to photos_url, flash: {notice: "Delete successfully."}
    else
      redirect_to photos_url, flash: {notice: "OVERDUE, can not delete this task."}
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :date, :description, :file_location)
  end

end
