class PlansController < ApplicationController
  def index
  end

  def create
    goal = params[:goal]
    level = params[:level]
    days = params[:days]

    file_key = "#{goal}_#{level}_#{days}_days"
    filepath = Rails.root.join("config/training_plans/#{file_key}.yml")

    if File.exist?(filepath)
      @plan = YAML.load_file(filepath)
      render :show  # renders app/views/plans/show.html.erb
    else
      redirect_to root_path, alert: "Sorry, no training plan found for that combination."
    end
  end

  def show
    goal = params[:goal]
    level = params[:level]
    days = params[:days]

    file_key = "#{goal}_#{level}_#{days}_days"
    filepath = Rails.root.join("config/training_plans/#{file_key}.yml")

    if File.exist?(filepath)
      @plan = YAML.load_file(filepath)
    else
      @error = "No matching plan found."
    end

    render :show
  end

end
