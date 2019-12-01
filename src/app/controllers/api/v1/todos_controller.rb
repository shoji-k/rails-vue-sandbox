class Api::V1::TodosController < Api::V1::ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    todos = Todo.all
    render json: TodoSerializer.new(todos).serialized_json
  end

  # GET /todos/1
  def show
    render json: TodoSerializer.new(@todo).serialized_json
  end

  # POST /todos
  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: TodoSerializer.new(todo).serialized_json, status: :created, location: api_v1_todo_path(todo)
    else
      render_error(todo)
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      render json: TodoSerializer.new(@todo).serialized_json
    else
      render_error(@todo)
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(Todo.column_names)
  end
end
