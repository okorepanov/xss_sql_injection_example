class Comment < ApplicationRecord
  before_save :set_random_author

  validates_presence_of :body

  private

  def set_random_author
    self.author = Faker::Name.name
  end
end
