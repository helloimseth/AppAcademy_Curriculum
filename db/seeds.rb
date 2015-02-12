# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Band.create!(name: "The Beatles")
b2 = Band.create!(name: "The Grateful Dead")

a1 = Album.create!(title: "Abbey Road", band_id: b1.id,
               setting: "Studio")
a2 = Album.create!(title: "The White Album", band_id: b1.id,
               setting: "Studio")

a3 = Album.create!(title: "American Beauty", band_id: b2.id,
               setting: "Studio")
a4 = Album.create!(title: "Skeletons from the Closet", band_id: b2.id,
               setting: "Compilation")

t1 = Track.create!(name: "Oh, Darlin!", album_id: a1.id,
               level: "Regular", lyrics: "Oh, Darlin! Please believe me!")
t2 = Track.create!(name: "Her Magesty", album_id: a1.id,
               level: "Bonus", lyrics: "Her Magesty's a pretty nice girl, but she doesn't have a lot to say")
t3 = Track.create!(name: "Why Don't We Do It In The Road?", album_id: a2.id,
               level: "Regular", lyrics: "No one will be watching us!")
t4 = Track.create!(name: "Revolution No. 9", album_id: a2.id,
               level: "Regular", lyrics: "Number 9?....Number 9?")

t5 = Track.create!(name: "Box of Rain", album_id: a3.id,
              level: "Regular", lyrics: "And it's just a box of rain, I don't know who put it there. Believe it if you need to, or leave it if you dare")
t6 = Track.create!(name: "Sugar Magnolia", album_id: a3.id,
              level: "Regular", lyrics: "Sugar Magnolia, blossoms bloomin'! Head's all empty and I don't care")
t7 = Track.create!(name: "Mexicali Blues", album_id: a4.id,
              level: "Regular", lyrics: "Laid up in an old saloon with a peso in my hand...")
t8 = Track.create!(name: "Friend of the Devil", album_id: a4.id,
              level: "Regular", lyrics: "I set out running but I'll take my time. A friend of the Devil is a friend of mine")
