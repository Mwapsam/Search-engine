Article.destroy_all

50.times do |index|
    Article.create(title: Faker::Books::CultureSeries.book) do |article|
        article.body = Faker::Lorem.paragraph_by_chars(number: 2000, supplemental: false)
    end
end