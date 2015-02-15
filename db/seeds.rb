u1 = User.create!(email: "fluffykitty@aol.com", password: "kittykitty")
u2 = User.create!(email: "bono@ego.org", password: "catorse")

s1 = u1.moderated_subs.create!(title: "Cats", description: "Poor man's dog")
s2 = u1.moderated_subs.create!(title: "Dogs", description: "Rich man's cat")

s3 = u2.moderated_subs.create!(title: "BonoFacts", description: "U don't know what u don't know")
s4 = u2.moderated_subs.create!(title: "Edge", description: "Don't cut yourself")

p1 = u1.posts.create!(title: "Test title 1", url: "http://www.google.com")
p2 = u1.posts.create!(title: "Test title 2", content: "content1")
p3 = u1.posts.create!(title: "Test title 3", url: "http://www.bing.com")
p4 = u1.posts.create!(title: "Test title 4", content: "content2")

p5 = u2.posts.create!(title: "Test title 5", content: "content3")
p6 = u2.posts.create!(title: "Test title 6", url: "http://www.yahoo.com")
p7 = u2.posts.create!(title: "Test title 7", content: "content4")
p8 = u2.posts.create!(title: "Test title 8", url: "http://www.espn.com")

ps1 = PostSub.create!(sub_id: s1.id, post_id: p1.id)
ps2 = PostSub.create!(sub_id: s2.id, post_id: p1.id)
ps3 = PostSub.create!(sub_id: s2.id, post_id: p2.id)
ps4 = PostSub.create!(sub_id: s3.id, post_id: p3.id)
ps5 = PostSub.create!(sub_id: s4.id, post_id: p2.id)
ps6 = PostSub.create!(sub_id: s4.id, post_id: p4.id)
