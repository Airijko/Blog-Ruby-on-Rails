class PostForm < ApplicationRecord
    validates :description, presence: true
    validates :tags, presence: true, length: { minimum: 1 }
end
