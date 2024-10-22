require 'rails_helper'

RSpec.describe Movie, type: :model do
    it 'is valid with valid attributes' do
        movie = Movie.new(
            show_id: 's1',
            title: 'Filme Teste',
            release_year: 2024,
            country: 'Brazil',
            listed_in: 'Drama',
            description: 'Descrição teste do filme teste'
        )
        expect(movie).to be_valid
    end

    it 'is not valid without a show_id' do
        movie = Movie.new(show_id: nil)
        expect(movie).not_to be_valid
    end

    it 'is not valid with a duplicate show_id' do
        Movie.create(
            show_id: 's1',
            title: 'Filme Teste',
            release_year: 2024,
            country: 'Brazil',
            listed_in: 'Drama',
            description: 'Descrição teste do filme teste'
        )
        movie = Movie.new(show_id: 's1')
        expect(movie).not_to be_valid
    end
end