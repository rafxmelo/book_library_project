# db/seeds.rb
require 'open-uri'
require 'json'

# Create Categories
fiction = Category.find_or_create_by(name: 'Fiction')
non_fiction = Category.find_or_create_by(name: 'Non-Fiction')

# Create Authors
authors = [
  { name: 'George Orwell', biography: 'George Orwell was an English novelist and journalist.' },
  { name: 'J.K. Rowling', biography: 'J.K. Rowling is a British author, best known for the Harry Potter series.' }
].map { |author_attrs| Author.find_or_create_by(author_attrs) }

# Fetch Data from Open Library API
isbns = ['0451526538', '0385472579', '0201558025']
categories = [fiction, non_fiction]

isbns.each do |isbn|
  url = "https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data"
  response = URI.open(url).read
  book_data = JSON.parse(response)["ISBN:#{isbn}"]

  # Ensure we have a valid publish_date
  publish_date = book_data['publish_date'] || Faker::Date.between(from: '1900-01-01', to: Date.today)

  Book.create(
    title: book_data['title'],
    isbn: isbn,
    cover_url: book_data.dig('cover', 'large'),
    category: categories.sample,
    author: authors.sample,
    published_date: publish_date,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )
end

# Create Additional Books with Faker
100.times do
  Book.create(
    title: Faker::Book.title,
    isbn: Faker::Number.unique.number(digits: 10).to_s,
    cover_url: 'https://via.placeholder.com/150',
    category: categories.sample,
    author: authors.sample,
    published_date: Faker::Date.between(from: '1900-01-01', to: Date.today),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )
end
