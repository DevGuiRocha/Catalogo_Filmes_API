require 'csv'

class Api::V1::MoviesController < ApplicationController
    def import_csv
        file = params[:file]

        if file.nil?
            render :json { error: 'Arquivo CSV é necessário' }, status: :unprocessable_entity
            return
        end

        CSV.foreach(file.path, headers: true) do |row|
            movie_params = {
                show_id: row['show_id'],
                type: row['type'],
                title: row['title'],
                director: row['director'],
                cast: row['cast'],
                country: row['country'],
                date_added: row['row'],
                release_year: row['release_year'],
                rating: row['rating'],
                duration: row['duration'],
                listed_in: row['listed_in'],
                description: row['description']
            }

            Movie.find_or_create_by(show_id: movie_params[:show_id]).update(movie_params)
        end

        render :json { message: 'Filmes importados com sucesso' } status: :ok
    end

    def index
        movies = Movie.all
        movies = movies.order(release_year: :desc)

        #Filtros para testes, modificados em breve
        movies = movies.where(release_year: params[:year]) if params[:year].present?
        movies = movies.where(genre: params[:genre]) if params[:genre].present?
        movies = movies.where(country: params[:country]) if params[:country].present?

        render :json movies.map { |movie| format_movie(movie) }
    end

    private

    def format_movie(movie)
        {
            id: movie.show_id
            title: movie.title
            genre: movie.listed_in
            year: movie.release_year
            country: movie.country
            published_at: movie.date_added
            description: movie.description
        }
    end

end