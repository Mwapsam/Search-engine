This is a Turbocharged real-time search build with Ruby on Rails 7. It allows users to search for the articles, and then have analytics that display what users were searching for. 

## Archetecture
The application has three tables in the database; 
- Users: Stores user data,
- Articles: Stores articles,
- UserSearches: Stores user's search results. Stored results are later analised and displayed.

## Realtime features
To efficiently query the database for the searched items, I used PgSearch gem which takes advantage of PostgreSQL's full text search.


    class Article < ApplicationRecord
        include PgSearch::Model

        pg_search_scope :article_search,
                        against: [:title],
                        using: { tsearch: { prefix: true } }
    end

I used pg_search_scope to build a search scope. The parameter article_search is a scope name, and the :against, tells pg_search_scope which column or columns to search against. The :tsearch (Full Text Search) feature with prefix: true  option, match the prefix of the items with the input query.

In the controller I passed `params[:query]` to the `:article_search` which contain user input. The user input is then used to search in the `:title` column, matched results are then stored in a `@search_results` variable which is iterated and passed to the `save_results` method. 

        def search
            if params[:query].present?
                @search_results = Article.article_search(params[:query])
                @search_results.each do |article|
                    save_results(article.title)
                end
            else
                @search_results = []
            end
        end
 
The `save_results` method saves the user's search results to user_searches table.

## Automatic Realtime Search
To make the automatic realtime search, I used Stimulus JS that comes with Rails 7. In the app/javascript/controllers/search_form.js, I wrote the following code.

    import { Controller } from "@hotwired/stimulus"

    export default class extends Controller {
        search() {
            clearTimeout(this.timeout)
                this.timeout = setTimeout(() => {
                    this.element.requestSubmit()
            }, 1000)
        }
    }

The `search()` method is called as a user triggers the input event on the text field. Then the javascript function `setTimeout` submits the form every 1 second. The `clearTimeout` function is called each time an input event gets triggered to acts as a looping mechanism for the life span of the input event. 
The `data-controller` element is needed to make javascript work in the form.

    <%= form_with(url: search_articles_path, method: :post, data: {controller: "search-form", turbo_frame: "articles", turbo_action: "advance"}, class: "form-outline mb-4") do |form| %>
            <%= form.label :query, "Search by title:", class: "form-label" %>
            <%= form.text_field :query, class: "form-control", data: {action: "input->search-form#search"} %>
    <% end %>

Here we listen for the input event and then target the stimulus controller search method. `(data: {action: "input->search-form#search"})`.



## Built With

- Ruby on Rails
- Bootstrap
- Ruby
- Stimulus JS


## Getting Started

**To get a local copy up and running follow these simple example steps.**

### Prerequisites
- Ruby should be installed on your machine
- Install Ruby on Rails and PostgresQL

### Setup
```
git clone https://github.com/Mwapsam/Search-engine.git
cd Search-engine
```
### Install
```
bundle install
```

### Play with the code
```
rails c
```

### Populate the db with dummy data
```
rake db:migrate
rake db:seed
```

### Run linters
```
rubocop -A
```

### Start the application
```
rails s
```

### Tests
```
rspec spec (run all tests)
rspec spec/name_of_folder/name_of_file.rb (run specific tests)
```

### Author

## 👤 Mwape Samuel

- GitHub: [@mwapsam](https://github.com/Mwapsam)
- Twitter: [@mwapesamuel4](https://twitter.com/mwapesamuel4)
- LinkedIn: [mwapsam](https://www.linkedin.com/in/mwapsam/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments
- Many thanks to Helpjuice

## 📝 License

This project is [MIT](./MIT.md) licensed.
