class Movie < ApplicationRecord
    validates :show_id, :title, :release_year, :country, :listed_in, :description, presence: true
    validates :show_id, uniqueness: true
end
