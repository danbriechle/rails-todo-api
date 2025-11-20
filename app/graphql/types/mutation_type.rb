# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World"
    # end

    field :create_todo, Types::TodoType, null: false do
      description "Create a new todo"
      argument :title, String, required: true
      argument :description, String, required: false
      argument :completed, Boolean, required: false
    end

    def create_todo(title:, description: nil, completed: false)
      Todo.create!(
        title: title,
        description: description,
        completed: completed
      )
    end

    field :update_todo, Types::TodoType, null: false do
      description "Update an existing todo"
      argument :id, ID, required: true
      argument :title, String, required: false
      argument :description, String, required: false
      argument :completed, Boolean, required: false
    end

    def update_todo(id:, title: nil, description: nil, completed: nil)
      todo = Todo.find(id)
      attrs = {}
      attrs[:title] = title unless title.nil?
      attrs[:description] = description unless description.nil?
      attrs[:completed] = completed unless completed.nil?
      todo.update!(attrs)
      todo
    end

    field :delete_todo, Boolean, null: false do
      description "Delete a todo"
      argument :id, ID, required: true
    end

    def delete_todo(id:)
      todo = Todo.find(id)
      todo.destroy!
      true
    end

  end
end
