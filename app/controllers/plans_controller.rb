class PlansController < ApplicationController
  def index
  end

  def create
    goal = params[:goal]
    level = params[:level]
    days = params[:days]
    email = params[:email]  # Capture the email

    # Optional: save email to a file or database for now (lightweight)
    Rails.logger.info("New lead: #{email} - #{goal} / #{level} / #{days} days")

    # Save email for later use (optional)
    session[:user_email] = email

    file_key = "#{goal}_#{level}_#{days}_days"
    filepath = Rails.root.join("config/training_plans/#{file_key}.yml")

    if File.exist?(filepath)
      @plan = YAML.load_file(filepath)
      render :show
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
