class ProjectsController < ApplicationController

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      # nothing, yet
    end
  end

  def index

  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
  end

end
