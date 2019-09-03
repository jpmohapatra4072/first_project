# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
  roles = Role.create([{ name: 'Admin' }, { name: 'Customer' }]) unless Role.first.present?
  user = User.new(
  	:first_name			   => "jyoti",
  	:last_name			   => "mohapatra",
  	:email                 => "jyotiprakashm@mindfiresolutions.com",
  	:password              => "Test@123",
  	:password_confirmation => "Test@123",
  	:role_id			   => Role.first.id,
  	:image 			   	   => File.new(Rails.root.join('app', 'assets', 'images', 'user.jpg'))
  )
  user.skip_confirmation!
  if user.save
  	user.paintings.build({name: 'first_painting', painting: File.new(Rails.root.join('app', 'assets', 'images', 'painting.jpg')) })
  	user.save
  end
#   Character.create(name: 'Luke', movie: movies.first)
