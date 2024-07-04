require 'open-uri'
require 'json'

Category.create(name: 'Fiction')
Category.create(name: 'Non-Fiction')

categories = Category.all

isbns = ['0451526538', '0385472579', '0201558025']

isbns.each do |isbn|
  url = "https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data"
  response = URI.open(url).read
  book_data = JSON.parse(response)["ISBN:#{isbn}"]

  Book.create(
    title: book_data['title'],
    author: book_data['authors'][0]['name'],
    published_date: book_data['publish_date'],
    isbn: isbn,
    cover_url: book_data.dig('cover', 'large'),
    category: categories.sample
  )
end

100.times do
  Book.create(
    title: Faker::Book.title,
    author: Faker::Book.author,
    published_date: Faker::Date.between(from: '1900-01-01', to: Date.today),
    isbn: Faker::Number.unique.number(digits: 10).to_s,
    cover_url: 'https://via.placeholder.com/150',
    category: categories.sample
  )
end
