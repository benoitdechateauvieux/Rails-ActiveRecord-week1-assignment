# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TodoList.destroy_all
Profile.destroy_all
User.destroy_all

Profile.create! [
	{first_name: 'Carly', last_name:'Fiorina', birth_year:1954, gender:'female'},
	{first_name: 'Donald', last_name:'Trump', birth_year:1946, gender:'male'},
	{first_name: 'Ben', last_name:'Carson', birth_year:1951, gender:'male'},
	{first_name: 'Hillary', last_name:'Clinton', birth_year:1947, gender:'female'}
]

Profile.all.each do |profile|
	user = profile.create_user!(username:"#{profile.last_name}", password_digest:"#{profile.first_name.downcase}")
	user.todo_lists << TodoList.create(list_name:"#{profile.first_name}'s list", list_due_date:(Date.today+1.year))
	(0...5).each do |i|
		user.todo_lists.first.todo_items << TodoItem.create(due_date:(Date.today+1.year), 
								title:"#{profile.first_name}'s item number #{i}", description:"description for item number #{i}", completed:false)
	end
end