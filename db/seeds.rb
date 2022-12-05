Article.destroy_all

50.times do |index|
    Article.create(title: Faker::Books::CultureSeries.book) do |article|
        article.body = Faker::Lorem.paragraphs(number: 20)
    end
end