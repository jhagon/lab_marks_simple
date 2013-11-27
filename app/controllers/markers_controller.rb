class MarkersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :new, :destroy, :index]
  before_filter :correct_marker, :only => [:show]
  helper_method :sort_column, :sort_direction

  def index
    @title = "List Markers"
    @markers = Marker.order("last ASC")
  end


  def show
    @title = "Show Marker"
    @marker = Marker.find(params[:id])
    @sheets = @marker.sheets.paginate(:page => params[:page],
             :per_page => 10).all( 
             :joins => [:experiment, :student],
             :order => "#{sort_column} #{sort_direction}")

  end

  def new
    @title = "New Marker"
    @marker = Marker.new
  end

  def create
    @marker = Marker.new(params[:marker])
    if @marker.save
      # handle a successful save 
      redirect_to markers_path, :notice => "Successfully created marker."
    else
      @title = "New Marker"
      render 'new'
    end
  end

  def edit
    @title = "Edit Marker"
    @marker = Marker.find(params[:id])
  end

  def update
    @marker = Marker.find(params[:id])
    if @marker.update_attributes(params[:marker])
#      redirect_to @marker, :notice  => "Successfully updated marker."
      redirect_to :back, :notice  => "Successfully updated marker."
    else
      render :action => 'edit'
    end
  end


  def destroy
    @marker = Marker.find(params[:id])
    @marker.destroy
    redirect_to markers_url, :notice => "Successfully destroyed marker."
  end

private

  def authenticate
    deny_access unless signed_in? && is_admin?
  end

  def correct_marker
    @marker = Marker.find(params[:id])
    redirect_to(root_path) unless ( current_marker?(@marker) || is_admin? )
  end

  def sort_column
    cols = Sheet.column_names + Experiment.column_names + Student.column_names
    cols.include?(params[:sort]) ? params[:sort] : "last"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
