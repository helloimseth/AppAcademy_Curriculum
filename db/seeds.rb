u1 = User.create!(email: "fluffykitty@aol.com", password: "kittykitty")
u2 = User.create!(email: "bono@ego.org", password: "catorse")

s1 = u1.moderated_subs.create!(title: "Cats", description: "Poor man's dog")
s2 = u1.moderated_subs.create!(title: "Dogs", description: "Rich man's cat")

s3 = u2.moderated_subs.create!(title: "BonoFacts", description: "U don't know what u don't know")
s4 = u2.moderated_subs.create!(title: "Edge", description: "Don't cut yourself")
