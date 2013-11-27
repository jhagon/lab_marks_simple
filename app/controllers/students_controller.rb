class StudentsController < ApplicationController

  before_filter :authenticate, :only => [:edit, :create, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @title = "List Students"
    @students = Student.paginate(:page => params[:page]).all(
                         :order => "#{sort_column} #{sort_direction}")

  end

  def import
  Student.import(params[:file])
  redirect_to students_path, notice: "Students imported."
  end

  def show
    @title = "Show Student"
    @student = Student.find(params[:id])
#
# can't use @student.sheets here because partner_id was declared
# as a foreign key and seems to take precedence. In other words
# @student.sheets returns all the sheets where the student is a
# partner rather than the student being marked.
#
    @sheets = Sheet.where("student_id = #{@student.id}").paginate(:page => params[:page],
    :per_page => 10).all(
    :joins => [:experiment, :marker],
    :order => "#{sort_column} #{sort_direction}")

  end

  def new
    @title = "New Student"
    @student = Student.new
  end

  def create
    @student = Student.new(params[:student])
    if @student.save
      redirect_to @student, :notice => "Successfully created student."
    else
      render :action => 'new'
    end
  end

  def edit
    @title = "Edit Student"
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      redirect_to @student, :notice  => "Successfully updated student."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_url, :notice => "Successfully destroyed student."
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

end
