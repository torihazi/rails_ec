# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

50.times do |_n|
  product = Product.create!(name: Faker::Commerce.product_name,
                            price: (Faker::Commerce.price * 100).floor(-2),
                            description: 'テストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト')
  product.image.attach(
    io: File.open(Rails.root.join('app/assets/images/450x300.jpg')),
    filename: '450x300.jpg'
  )
end
