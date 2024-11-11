# db/seeds/scrape_products.rb
require 'nokogiri'
require 'httparty'

# Define the URL of the page to scrape
url = 'http://books.toscrape.com/catalogue/category/books_1/index.html'

# Fetch and parse the page HTML
response = HTTParty.get(url)
parsed_page = Nokogiri::HTML(response.body)

# Extract product data from the page
parsed_page.css('.product-item').each do |product|
  name = product.css('.product-name').text.strip
  description = product.css('.product-description').text.strip
  price_text = product.css('.product-price').text.strip
  price = price_text.gsub('$', '').to_f
  category_name = product.css('.product-category').text.strip

  # Debugging: Print extracted values
  puts "Scraped product - Name: #{name}, Price: #{price}, Category: #{category_name}"

  # Find or create the category
  category = Category.find_or_create_by(name: category_name)

  # Create the product with scraped data
  new_product = Product.create(
    name: name,
    description: description,
    price: price,
    category: category
  )

  # Check if the product was successfully saved and provide feedback
  if new_product.persisted?
    puts "Successfully saved #{name}"
  else
    puts "Failed to save #{name}: #{new_product.errors.full_messages.join(", ")}"
  end
end

puts "Seeding completed successfully!"
