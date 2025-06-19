module Admin
  class TrainingPlansController < ApplicationController
    before_action :set_file_key, only: [:edit, :update]

    # Show list of plans (goal/level/days combos)
    def index
      @plans = available_plans
    end

    # Load YAML content into textarea
    def edit
      filepath = plan_filepath(@file_key)
      if File.exist?(filepath)
        @yaml_content = File.read(filepath)
      else
        @yaml_content = "# File not found."
      end
    end

    # Save YAML content back to file
    def update
      filepath = plan_filepath(@file_key)
      File.write(filepath, params[:yaml_content])
      redirect_to admin_training_plans_path, notice: "Plan updated successfully."
    rescue => e
      flash.now[:alert] = "Failed to save: #{e.message}"
      render :edit
    end

    private

    def set_file_key
      @file_key = params[:file_key]
    end

    def available_plans
      Dir.glob(Rails.root.join('config/training_plans/*.yml')).map do |f|
        File.basename(f, '.yml')
      end
    end

    def plan_filepath(key)
      Rails.root.join("config/training_plans/#{key}.yml")
    end
  end
end
