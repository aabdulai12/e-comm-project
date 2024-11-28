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
Province.create([
  { name: 'Alberta' },
  { name: 'British Columbia' },
  { name: 'Manitoba' },
  { name: 'New Brunswick' },
  { name: 'Newfoundland and Labrador' },
  { name: 'Nova Scotia' },
  { name: 'Ontario' },
  { name: 'Prince Edward Island' },
  { name: 'Quebec' },
  { name: 'Saskatchewan' },
  { name: 'Northwest Territories' },
  { name: 'Nunavut' },
  { name: 'Yukon' }
])





# Update each province with its GST, PST, and HST rates

Province.find_by(name: 'Alberta').update(gst: 0.05, pst: 0.0, hst: 0)
Province.find_by(name: 'British Columbia').update(gst: 0.05, pst: 0.07, hst: 0)
Province.find_by(name: 'Manitoba').update(gst: 0.05, pst: 0.07, hst: 0)
Province.find_by(name: 'New Brunswick').update(gst: 0, pst: 0, hst: 0.15)
Province.find_by(name: 'Newfoundland and Labrador').update(gst: 0, pst: 0, hst: 0.15)
Province.find_by(name: 'Nova Scotia').update(gst: 0, pst: 0, hst: 0.15)
Province.find_by(name: 'Ontario').update(gst: 0, pst: 0, hst: 0.13)
Province.find_by(name: 'Prince Edward Island').update(gst: 0, pst: 0, hst: 0.15)
Province.find_by(name: 'Quebec').update(gst: 0.05, pst: 0.09975, hst: 0)
Province.find_by(name: 'Saskatchewan').update(gst: 0.05, pst: 0.06, hst: 0)
Province.find_by(name: 'Northwest Territories').update(gst: 0.05, pst: 0, hst: 0)
Province.find_by(name: 'Nunavut').update(gst: 0.05, pst: 0, hst: 0)
Province.find_by(name: 'Yukon').update(gst: 0.05, pst: 0, hst: 0)


puts "All provinces and territories updated with tax rates."



Status.find_or_create_by(title: 'unpaid')
Status.find_or_create_by(title: 'paid')
