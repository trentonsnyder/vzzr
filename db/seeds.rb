company1 = Company.create(kind: 'creator', name: 'Create Co', description: Faker::Hipster.sentences(1).first)
company2 = Company.create(kind: 'publisher', name: 'Pub Co', description: Faker::Hipster.sentences(1).first)
creator = User.create(email: 'creator@example.com', password: 'password', company_id: company1.id, name: Faker::Seinfeld.character)
publisher = User.create(email: 'publisher@example.com', password: 'password', company_id: company2.id, name: Faker::Seinfeld.character)

convo = Conversation.create(user_1_id: creator.id, user_2_id: publisher.id)

convo.messages.create(body: Faker::Seinfeld.quote, user_id: creator.id)
convo.messages.create(body: Faker::Seinfeld.quote, user_id: creator.id)
convo.messages.create(body: Faker::Seinfeld.quote, user_id: publisher.id)
convo.messages.create(body: Faker::Seinfeld.quote, user_id: creator.id)
convo.messages.create(body: Faker::Seinfeld.quote, user_id: publisher.id)
convo.messages.create(body: Faker::Seinfeld.quote, user_id: creator.id)
convo.messages.create(body: Faker::Seinfeld.quote, user_id: publisher.id)
convo.messages.create(body: Faker::Seinfeld.quote, user_id: publisher.id)
convo.messages.create(body: Faker::Seinfeld.quote, user_id: publisher.id)
convo.messages.create(body: Faker::Seinfeld.quote, user_id: creator.id)

cats = ['Action/Adventure', 'Crime/Detective', 'Fantasy', 'Horror', 'Humor', 'Mystery', 'Science fiction', 'Suspense/Thriller', 'Western', 'Biography']

cats.each { |c| Genre.create(name: c) }

12.times do
  Company.create(kind: 'publisher', name: Faker::Pokemon.name, description: Faker::Hipster.sentences(1).first)
end

12.times do
  Company.create(kind: 'creator', name: Faker::DragonBall.character, description: Faker::Hipster.sentences(1).first)
end