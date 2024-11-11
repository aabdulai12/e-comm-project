#require 'faker'
require 'csv'

# Define Categories
categories = ["Energy-Efficient Devices", "Solar-Powered Gadgets", "Refurbished Electronics"]

# Create Categories if they don't already exist
category_records = categories.map { |category| Category.find_or_create_by(name: category) }

puts "Categories seeded: #{category_records.map(&:name).join(', ')}"

# Seed with Faker (e.g., 100 products)
#100.times do
  #product = Product.create!(
   # name: Faker::Commerce.product_name,
   # description: Faker::Lorem.sentence(word_count: 15),
   # price: Faker::Commerce.price(range: 10.0..1000.0),
   # category: category_records.sample,
  #  stock_quantity: rand(1..50)
  #)
  #puts "Faker product created: #{product.name} in category #{product.category.name}"
#end

# Seed from CSV file (if using CSV data)
csv_path = Rails.root.join('db', 'products.csv')
if File.exist?(csv_path)
  puts "CSV file found at #{csv_path}, starting import."
  CSV.foreach(csv_path, headers: true) do |row|
    category = Category.find_or_create_by(name: row['category'])
    product = Product.create!(
      name: row['name'],
      description: row['description'],
      price: row['price'].to_f,
      category: category,
      stock_quantity: rand(1..50)
    )
    puts "CSV product created: #{product.name} in category #{product.category.name}"
  end
else
  puts "CSV file not found at #{csv_path}"
end

puts "Seeding completed successfully!"
