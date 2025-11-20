# frozen_string_literal: true

module Types
  class TodoType < Types::BaseObject
    field :id, ID, null: false
    field :completed, Boolean
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :description, String
    field :title, String
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
