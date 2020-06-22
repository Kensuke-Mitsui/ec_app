
20.times do
  Product.create!(
    name: Faker::Book.title,
    description: Faker::Lorem.paragraph(2),
    price: Faker::Number.within(100..100000)
  )
end