FactoryBot.define do
    factory :movie do
        show_id { "s#{rand(1..1000)}" }
        title { "Filme Teste #{rand(1..10)}" }
        release_year { rand(1990..2023) }
        country { "United States" }
        listed_in { "Drama" }
        description { "Descrição de teste para o filme." }
    end
end  