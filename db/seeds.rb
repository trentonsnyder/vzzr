company1 = Company.create(kind: "creator", name: "Create Co", description: Faker::Hipster.sentences(1).first, cover_image_url: "//vzzr.s3-us-west-2.amazonaws.com/defaults/camel.jpg")
company2 = Company.create(kind: "publisher", name: "Pub Co", description: Faker::Hipster.sentences(1).first, cover_image_url: "//vzzr.s3-us-west-2.amazonaws.com/defaults/camel.jpg")

creator = User.create(email: "creator@example.com", password: "password", company_id: company1.id, name: Faker::Seinfeld.character)
publisher = User.create(email: "publisher@example.com", password: "password", company_id: company2.id, name: Faker::Seinfeld.character)

def_img_bank = [
  "//vzzr.s3-us-west-2.amazonaws.com/defaults/bear.jpg",
  "//vzzr.s3-us-west-2.amazonaws.com/defaults/marnie.jpg",
  "//vzzr.s3-us-west-2.amazonaws.com/defaults/capybara.jpg",
  "//vzzr.s3-us-west-2.amazonaws.com/defaults/narwhhal.jpg",
  "//vzzr.s3-us-west-2.amazonaws.com/defaults/tiger.jpg",
  "//vzzr.s3-us-west-2.amazonaws.com/defaults/dino.jpg",
  "//vzzr.s3-us-west-2.amazonaws.com/defaults/panda.jpg"
]

# "uploads/#{video.company_id}/videos/#{SecureRandom.uuid}${filename}"

12.times do
  co = Company.create(kind: "publisher", name: Faker::Pokemon.name, description: Faker::Hipster.sentences(1).first, cover_image_url: def_img_bank.sample)
  User.create(email: "creator#{co.id}@example.com", password: "password", company_id: co.id, name: Faker::Seinfeld.character)
end

12.times do
  co = Company.create(kind: "creator", name: Faker::DragonBall.character, description: Faker::Hipster.sentences(1).first, cover_image_url: def_img_bank.sample)
  User.create(email: "publisher#{co.id}@example.com", password: "password", company_id: co.id, name: Faker::Seinfeld.character)
end

def make_message(from_user, to_user)
  to_company = to_user.company
  message = { user_id: from_user.id, body: Faker::Seinfeld.quote, company_id: from_user.company.id }
  convo_ids = from_user.company.conversations.ids

  convo = to_company.conversations.where("conversations.id IN (?)", convo_ids).first

  if convo.nil?
    convo = Conversation.create()
    convo.participants.find_or_create_by(company_id: from_user.id)
    convo.participants.find_or_create_by(company_id: to_user.id)
  end
  convo.messages.create(message)
end

8.times do
  user_array = [creator, publisher]
  from = user_array.sample
  to = (user_array - [from]).pop
  make_message(from, to)
end

count = 0
500.times do
  puts count if count % 100 == 0
  user1 = Company.where(kind: "creator").order("RANDOM()").first.users.first
  user2 = Company.where(kind: "publisher").order("RANDOM()").first.users.first
  user_array = [user1, user2]
  from = user_array.sample
  to = (user_array - [from]).pop
  make_message(from, to)
  count += 1
end

cats = ["Action/Adventure", "Crime/Detective", "Fantasy", "Horror", "Humor", "Mystery", "Science fiction", "Suspense/Thriller", "Western", "Biography"]

cats.each { |c| Genre.create(name: c) }
