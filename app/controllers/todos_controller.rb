class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    todos = nil

    ActiveRecord::Base.connected_to(role: :reading) do
      todos = Todo.all
    end

    render json: todos
  end

  def show
    render json: @todo
  end

  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo, status: :created
    else
      render json: { errors: todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def set_todo
    ActiveRecord::Base.connected_to(role: :reading) do
      @todo = Todo.find(params[:id])
    end
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end
