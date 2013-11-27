class SheetsController < ApplicationController

  before_filter :authenticate, :only => [:destroy, :index]
  before_filter :correct_marker, :only => [:edit, :show]
  helper_method :sort_column, :sort_direction

  def index
    @sheets = Sheet.paginate(:page => params[:page]).all( :joins => [:experiment, :student],
                         :order => "#{sort_column} #{sort_direction}")
    @title = "List Mark Sheets"
  end

  def show
    @sheet = Sheet.find(params[:id])
    @returned_mark = @sheet.raw_mark * @sheet.marker.scaling 
                      + @sheet.marker.shift
    @returned_mark = @returned_mark.to_int
    @returned_mark = @returned_mark > 100 ? 100 : @returned_mark
    @title = "Show Mark Sheet"
  end

  def new
    @sheet = Sheet.new
    @title = "New Mark Sheet"
  end

  def create
    @sheet = Sheet.new(params[:sheet])
    unless is_admin?
      @sheet.marker_id = current_marker.id
    end
    if @sheet.save
      redirect_to @sheet, :notice => "Successfully created sheet."
    else
      render :action => 'new'
    end
  end

  def edit
    @sheet = Sheet.find(params[:id])
    @title = "Edit Mark Sheet"
  end

  def update
    @sheet = Sheet.find(params[:id])
    if @sheet.update_attributes(params[:sheet])
      redirect_to @sheet, :notice  => "Successfully updated sheet."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @sheet = Sheet.find(params[:id])
    @sheet.destroy
    redirect_to :back, :notice => "Successfully destroyed sheet."
  end

private

  def authenticate
    deny_access unless signed_in? && is_admin?
  end

  def sort_column
    cols = Sheet.column_names + Experiment.column_names + Student.column_names
    cols.include?(params[:sort]) ? params[:sort] : "last"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def correct_marker
      if current_marker.nil?
        deny_access
      else
        @sheet = current_marker.sheets.find_by(id: params[:id])
        deny_access unless is_admin?  || !@sheet.nil?
      end
    end

end
