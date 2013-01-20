class ProjectsController < ApplicationController

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash[:alert] = "Project has not been created."
      render :action => "new"
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