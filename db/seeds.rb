# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

subjects = ["Math 54", "CS 30", "Comm 3", "Kas 1", "CS 12", "Bio 1", "CW 10", "PE CH", "PE BW"]
units = [5,3]

for i in 0..20
  Course.create({name: subjects.sample,
                 demand: Random.rand(10),
                 units: units.sample,
                 descendants: Random.rand(10),
                 course_type: Random.rand(5),
                 timeslot: [8,24]})
end
