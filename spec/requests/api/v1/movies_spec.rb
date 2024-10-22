require 'rails_helper'

RSpec.describe 'Movies API', type: :request do
    describe 'POST /api/v1/movies/import_csv' do
        let(:file) { fixture_file_upload('netflix_titles.csv', 'text/csv') }

        it 'imports movies from csv' do
            post '/api/v1/movies/import_csv', params: { file: file }
            expect(response).to have_http_status(:ok)
            expect(response.body).to include('Filmes importados com sucesso')
        end

        it 'returns an error if file is not provided' do
            post '/api/v1/movies/import_csv'
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.body).to include('Arquivo CSV é necessário')
        end
    end

    describe 'GET /api/v1/movies' do
        before do
            FactoryBot.create(:movie, title: 'Filme Teste 1', release_year: 2019)
            FactoryBot.create(:movie, title: 'Filme Teste 2', release_year: 2020)
            FactoryBot.create(:movie, title: 'Filme Teste 3', release_year: 2021)
        end

        it 'returns all movies ordered by release year' do
            get '/api/v1/movies'
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body).first['title']).to eq("Filme Teste 3")
        end

        it 'filters movies by year' do
            get '/api/v1/movies', params: { year: 2019 }
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body).size).to eq(1)
        end
    end
end