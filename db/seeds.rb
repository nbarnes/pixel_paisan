# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# rubocop:disable Style/SpaceAroundOperators
perler_colors = [
  { 'r' =>  0,   'g' =>  0,   'b' =>  0,   'a' =>  1 },
  { 'r' =>  77,  'g' =>  77,  'b' =>  77,  'a' =>  1 },
  { 'r' =>  147, 'g' =>  147, 'b' =>  147, 'a' =>  1 },
  { 'r' =>  255, 'g' =>  255, 'b' =>  255, 'a' =>  1 },
  { 'r' =>  77,  'g' =>  43,  'b' =>  15,  'a' =>  1 },
  { 'r' =>  133, 'g' =>  82,  'b' =>  38,  'a' =>  1 },
  { 'r' =>  200, 'g' =>  158, 'b' =>  90,  'a' =>  1 },
  { 'r' =>  220, 'g' =>  158, 'b' =>  90,  'a' =>  1 },
  { 'r' =>  236, 'g' =>  228, 'b' =>  176, 'a' =>  1 },
  { 'r' =>  234, 'g' =>  177, 'b' =>  178, 'a' =>  1 },
  { 'r' =>  118, 'g' =>  20,  'b' =>  28,  'a' =>  1 },
  { 'r' =>  225, 'g' =>  0,   'b' =>  7,   'a' =>  1 },
  { 'r' =>  248, 'g' =>  50,  'b' =>  34,  'a' =>  1 },
  { 'r' =>  250, 'g' =>  69,  'b' =>  76,  'a' =>  1 },
  { 'r' =>  251, 'g' =>  104, 'b' =>  110, 'a' =>  1 },
  { 'r' =>  252, 'g' =>  150, 'b' =>  151, 'a' =>  1 },
  { 'r' =>  151, 'g' =>  37,  'b' =>  19,  'a' =>  1 },
  { 'r' =>  252, 'g' =>  74,  'b' =>  8,   'a' =>  1 },
  { 'r' =>  251, 'g' =>  112, 'b' =>  17,  'a' =>  1 },
  { 'r' =>  253, 'g' =>  151, 'b' =>  15,  'a' =>  1 },
  { 'r' =>  254, 'g' =>  225, 'b' =>  9,   'a' =>  1 },
  { 'r' =>  254, 'g' =>  239, 'b' =>  89,  'a' =>  1 },
  { 'r' =>  63,  'g' =>  0,   'b' =>  107, 'a' =>  1 },
  { 'r' =>  114, 'g' =>  25,  'b' =>  157, 'a' =>  1 },
  { 'r' =>  180, 'g' =>  116, 'b' =>  197, 'a' =>  1 },
  { 'r' =>  11,  'g' =>  0,   'b' =>  104, 'a' =>  1 },
  { 'r' =>  29,  'g' =>  0,   'b' =>  165, 'a' =>  1 },
  { 'r' =>  81,  'g' =>  71,  'b' =>  134, 'a' =>  1 },
  { 'r' =>  44,  'g' =>  97,  'b' =>  172, 'a' =>  1 },
  { 'r' =>  84,  'g' =>  141, 'b' =>  209, 'a' =>  1 },
  { 'r' =>  121, 'g' =>  186, 'b' =>  219, 'a' =>  1 },
  { 'r' =>  22,  'g' =>  105, 'b' =>  3,   'a' =>  1 },
  { 'r' =>  40,  'g' =>  121, 'b' =>  62,  'a' =>  1 },
  { 'r' =>  64,  'g' =>  171, 'b' =>  72,  'a' =>  1 },
  { 'r' =>  87,  'g' =>  199, 'b' =>  97,  'a' =>  1 },
  { 'r' =>  72,  'g' =>  248, 'b' =>  29,  'a' =>  1 }
]

html_colors = [
  { 'r' =>    0, 'g' =>  255, 'b' =>  255, 'a' =>  1 },
  { 'r' =>  255, 'g' =>  255, 'b' =>  255, 'a' =>  1 },
  { 'r' =>    0, 'g' =>    0, 'b' =>  255, 'a' =>  1 },
  { 'r' =>  255, 'g' =>    0, 'b' =>  255, 'a' =>  1 },
  { 'r' =>  128, 'g' =>  128, 'b' =>  128, 'a' =>  1 },
  { 'r' =>    0, 'g' =>  128, 'b' =>    0, 'a' =>  1 },
  { 'r' =>    0, 'g' =>  255, 'b' =>    0, 'a' =>  1 },
  { 'r' =>  128, 'g' =>    0, 'b' =>    0, 'a' =>  1 },
  { 'r' =>    0, 'g' =>    0, 'b' =>  128, 'a' =>  1 },
  { 'r' =>  128, 'g' =>  128, 'b' =>    0, 'a' =>  1 },
  { 'r' =>  255, 'g' =>  165, 'b' =>    0, 'a' =>  1 },
  { 'r' =>  128, 'g' =>    0, 'b' =>  128, 'a' =>  1 },
  { 'r' =>  255, 'g' =>    0, 'b' =>    0, 'a' =>  1 },
  { 'r' =>  192, 'g' =>  192, 'b' =>  192, 'a' =>  1 },
  { 'r' =>    0, 'g' =>  128, 'b' =>  128, 'a' =>  1 },
  { 'r' =>  255, 'g' =>  255, 'b' =>  255, 'a' =>  1 },
  { 'r' =>  255, 'g' =>  255, 'b' =>    0, 'a' =>  1 }
]
# rubocop:enable Style/SpaceAroundOperators

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create!(
  name: ENV['ADMIN_NAME'],
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
  role: 'admin'
)
puts 'New user created: ' << user.name

puts 'Importing perler palette'
perler_palette = Palette.create! name: 'Perler', user_id: user.id, is_default: true
perler_colors.each do |color|
  perler_palette.colors << color
end
perler_palette.save

puts 'Importing HTML palette'
html_palette = Palette.create! name: 'HTML colors', user_id: user.id, is_default: true
html_colors.each do |color|
  html_palette.colors << color
end
html_palette.save
