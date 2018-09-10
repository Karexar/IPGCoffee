# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create name: "Mike", balance: 5.0
User.create name: "Muriel", balance: 20.0
User.create name: "Giovanni", balance: -5.40

Product.create name: "Henniez", price: 1.80
Product.create name: "Coca", price: 1.80
Product.create name: "Orange", price: 1.20
Product.create name: "Coffee", price: 0.50
