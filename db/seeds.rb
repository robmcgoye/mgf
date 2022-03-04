# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
pages = %w(home about history mission philosophy)
pages.each do |page|
  pg = Page.new(
    name: page, 
    body: "#{page} body"
  )
  I18n.locale = :es
  pg.body = "#{page} marcador de posición"
  I18n.locale = :en
  pg.save
end
puts "Created all pages!"

