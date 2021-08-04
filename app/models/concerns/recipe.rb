class Recipe < ActiveRecord::Base
	validates :name, presence: true
	validates :description, presence: true, length: { minimum: 5, maximum: 500 }
	default_scope -> { order(updated_at: :desc) }
	belongs_to :chef
end