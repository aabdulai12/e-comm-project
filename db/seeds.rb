require "csv"

# Define Categories
categories = ["Energy-Efficient Devices", "Solar-Powered Gadgets", "Refurbished Electronics"]

# Create Categories if they don't already exist
category_records = categories.map { |category| Category.find_or_create_by(name: category) }

Rails.logger.debug "Categories seeded: #{category_records.map(&:name).join(', ')}"

# Seed products from CSV file (if CSV data is available)
csv_path = Rails.root.join("db/products.csv")
if File.exist?(csv_path)
  Rails.logger.debug "CSV file found at #{csv_path}, starting import..."
  CSV.foreach(csv_path, headers: true) do |row|
    category = Category.find_or_create_by(name: row["category"])
    product = Product.create!(
      name:           row["name"],
      description:    row["description"],
      price:          row["price"].to_f,
      category:       category,
      stock_quantity: rand(1..50) # You can remove this if stock_quantity exists in your CSV
    )
    Rails.logger.debug "CSV product created: #{product.name} in category #{product.category.name}"
  end
else
  Rails.logger.debug "CSV file not found at #{csv_path}. Please provide the CSV file to seed products."
end

Rails.logger.debug "Products seeding completed successfully!" if File.exist?(csv_path)

# Seed Provinces and Territories
provinces = [
  { name: "Alberta", gst: 0.05, pst: 0.0, hst: 0.0 },
  { name: "British Columbia", gst: 0.05, pst: 0.07, hst: 0.0 },
  { name: "Manitoba", gst: 0.05, pst: 0.07, hst: 0.0 },
  { name: "New Brunswick", gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: "Newfoundland and Labrador", gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: "Nova Scotia", gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: "Ontario", gst: 0.0, pst: 0.0, hst: 0.13 },
  { name: "Prince Edward Island", gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: "Quebec", gst: 0.05, pst: 0.09975, hst: 0.0 },
  { name: "Saskatchewan", gst: 0.05, pst: 0.06, hst: 0.0 },
  { name: "Northwest Territories", gst: 0.05, pst: 0.0, hst: 0.0 },
  { name: "Nunavut", gst: 0.05, pst: 0.0, hst: 0.0 },
  { name: "Yukon", gst: 0.05, pst: 0.0, hst: 0.0 }
]

provinces.each do |province_data|
  province = Province.find_or_create_by(name: province_data[:name])
  province.update!(gst: province_data[:gst], pst: province_data[:pst], hst: province_data[:hst])
  Rails.logger.debug "Province updated: #{province.name} with GST: #{province.gst}, PST: #{province.pst}, HST: #{province.hst}"
end

Rails.logger.debug "All provinces and territories updated with tax rates."

# Seed Order Statuses
statuses = ["unpaid", "paid"]
statuses.each do |status_title|
  status = Status.find_or_create_by(title: status_title) do |s|
    s.description = "Order is #{status_title}" if status_title == "unpaid"
  end
  Rails.logger.debug "Status created/updated: #{status.title}"
end

Rails.logger.debug "All statuses seeded successfully!"
