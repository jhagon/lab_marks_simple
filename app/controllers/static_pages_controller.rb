class StaticPagesController < ApplicationController

  before_filter :authenticate, :only => [:statistics, :marklist]

  def home
    @title="Home"
  end

  def contact
    @title="Contact"
  end

  def about
    @title="About"
  end

  def help
    @title="Help"
  end

  def statistics
    @title="Statistics"
    @sheets = Sheet.all
    @experiments = Experiment.all
    @markers = Marker.all
    @average = overall_average
  end

  def upload
    @title="Upload Data"
  end

  def marklist

    @students = Student.paginate(:page => params[:page]).per_page(12).all(
                         :order => "last ASC")
    @experiments = Experiment.all(
                         :order => "title ASC")

    respond_to do |format|
      format.html
      format.xls
    end
  end
end

  def overall_average
    sum = 0.0
    n_sheets = Sheet.all.count
    for sheet in Sheet.all
      sum = sum + sheet.return_mark
    end
    if n_sheets == 0
     overall_average = nil
    else
     overall_average = sum/n_sheets
    end
  end

  def marker_average(marker_id)
    marker_sheets = Sheet.where("marker_id = #{marker_id}")
    sum = marker_sheets.sum("raw_mark")
    n_sheets = marker_sheets.count
    if (n_sheets == 0)
      marker_average = nil
    else
      scale = Marker.find(marker_id).scaling
      shift = Marker.find(marker_id).shift
      marker_average = (scale * sum + shift)/n_sheets
    end
  end

  def marker_experiment_average(marker_id, experiment_id)
    sheets = Sheet.where(
     "marker_id = #{marker_id} AND experiment_id = #{experiment_id}")
    sum = sheets.sum("raw_mark")
    n_sheets = sheets.count
    if (n_sheets == 0)
      marker_experiment_average = nil
    else
      scale = Marker.find(marker_id).scaling
      shift = Marker.find(marker_id).shift
      marker_experiment_average = (scale * sum + shift)/n_sheets
    end
  end

  def experiment_average(experiment_id)
    sum = 0.0
    n_markers = 0 # markers who have actually marked
    for marker in Marker.all
      unless marker_experiment_average(marker.id, experiment_id).nil?
        n_markers = n_markers + 1
        sum = sum + marker_experiment_average(marker.id, experiment_id)
      end
    end
    if (n_markers == 0) 
      experiment_average = nil
    else
      experiment_average = sum/n_markers
    end
  end

  def student_experiment_mark(student_id,experiment_id)
    sheet = Sheet.where(
     "student_id = #{student_id} AND experiment_id = #{experiment_id}")
    if sheet.empty?
      return ""
    else
      student_experiment_mark = sheet.return_mark
    end
  end

private

  def authenticate
    deny_access unless signed_in? && is_admin?
  end

