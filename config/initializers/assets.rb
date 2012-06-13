puts "removing existing symbolic links for assets"

puts "    removing the fonts link..."
system("rm -f #{Rails.root}/public/fonts")
puts "    OK!"

puts "    removing the images link..."
system("rm -f #{Rails.root}/public/images")
puts "    OK!"

puts "    removing the javascripts link..."
system("rm -f #{Rails.root}/public/javascripts")
puts "    OK!"

puts "creating the symbolic link for assets"

puts "    creating the symbolic link for the fonts..."
system("ln -s #{Rails.root}/app/assets/fonts #{Rails.root}/public/fonts")
puts "    OK!"

puts "    creating the symbolic link for the images..."
system("ln -s #{Rails.root}/app/assets/images #{Rails.root}/public/images")
puts "    OK!"

puts "    creating the symbolic link for the javascripts..."
system("ln -s #{Rails.root}/app/assets/javascripts #{Rails.root}/public/javascripts")
puts "    OK!"
