# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# db/seeds.rb

# db/seeds.rb

# Create Organizations
org1 = Organization.find_or_create_by(name: 'elitmus.com')
org2 = Organization.find_or_create_by(name: 'Default')
org3 = Organization.find_or_create_by(name: 'gmail.org')

# Function to create users
# def create_user(email, password, organization)
#   User.find_or_create_by(email: email) do |user|
#     user.password = password
#     user.organization = organization
#     user.save!
#     puts "User Created: #{user.email}"
#   end
# end

# # Create Users
# # Create a admin user
# admin_user = create_user('admin@elitmus.com', 'password', org1)
# puts "Admin User Created: #{admin_user.email}"
# # Create multiple users for elitmus
# 5.times do |i|
#   user = create_user("user#{i}@elitmus.com", 'password', org1)
#   puts "User Created: #{user.email}"
# end

# # Sample Survey Topics and Questions
# survey_topics = [
#   {
#     title: "Gift Card Satisfaction Survey",
#     description: "We want to understand your overall satisfaction with our gift cards.",
#     questions: [
#       { type: 'multiple_choice', text: "How satisfied are you with our gift cards?", options: ["Very Satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very Dissatisfied"] },
#       { type: 'multiple_choice', text: "How likely are you to recommend our gift cards to a friend?", options: ["Very Likely", "Likely", "Neutral", "Unlikely", "Very Unlikely"] },
#       { type: 'short_answer', text: "What do you like most about our gift cards?" },
#       { type: 'short_answer', text: "What could we improve about our gift cards?" },
#       { type: 'true_false', text: "I found it easy to purchase and redeem the gift card." }
#     ]
#   },
#   {
#     title: "Gift Card Usage Survey",
#     description: "We want to understand how our customers are using gift cards.",
#     questions: [
#       { type: 'multiple_choice', text: "What did you use the gift card for?", options: ["Self-Purchase", "Gift for Someone Else", "Other"] },
#       { type: 'short_answer', text: "Where did you redeem the gift card?" },
#       { type: 'multiple_choice', text: "How often do you purchase gift cards?", options: ["Very Often", "Often", "Sometimes", "Rarely", "Never"] },
#       { type: 'short_answer', text: "How satisfied are you with the variety of gift cards we offer?" },
#       { type: 'multiple_choice', text: "What gift card services do you know", options: ["Starbucks", "Amazon", "Itunes", "Steam"] }
#     ]
#   },
#   {
#     title: "Gift Card Preferences Survey",
#     description: "We want to understand your preferences regarding gift cards.",
#     questions: [
#       { type: 'multiple_choice', text: "What type of gift card do you prefer?", options: ["Physical Gift Card", "Digital Gift Card", "No Preference"] },
#       { type: 'multiple_choice', text: "Do you prefer a specific design on gift card", options: ["Yes, Seasonal design.", "Yes, Company design", "I don't have any preference"] },
#       { type: 'short_answer', text: "What denomination of gift card do you prefer?" },
#       { type: 'multiple_choice', text: "What's your favorite style", options: ["It doesn't matter", "Gift it for friends or families","Gift it to my lover"] },
#       { type: 'multiple_choice', text: "Would you like to have a gift card or gift vouchers?", options: ["Gift Card", "Gift Vouchers", "Any"] }
#     ]
#   }
# ]

# # Create Surveys
# survey_topics.each_with_index do |topic, i|
#   survey = Survey.create!(
#     user: admin_user,
#     title: topic[:title],
#     description: topic[:description],
#     theme: ['light', 'dark', 'blue', 'green'].sample
#   )
#   puts "Survey Created: #{survey.title}"

#   # Create Questions for each survey
#   topic[:questions].each_with_index do |question_data, j|
#     question_type = question_data[:type]
#     question_text = question_data[:text]
#     options = question_data[:options]

#     Question.create!(
#       survey: survey,
#       question_type: question_type,
#       text: question_text,
#       options: options,
#       required: [true, false].sample,
#       order: j + 1
#     )
#     puts "Question Created for Survey: #{question_text}"
#   end
# end

# # Create Responses for the first 3 Surveys
# Survey.first(3).each do |survey|
#   User.all.each do |user|
#     response = Response.create!(survey: survey, user: user)

#     survey.questions.each do |question|
#       answer_text = if question.options.present?
#          case question.question_type
#             when 'multiple_choice', 'true_false'
#             question.options.sample # Select a random option
#             when 'short_answer', 'fill_in_the_blanks'
#             Faker::Lorem.sentence
#             else #image_upload, file_upload
#             "Placeholder File URL"
#          end
#          else
#           Faker::Lorem.sentence
#         end

#       Answer.create!(
#         response: response,
#         question: question,
#         text_value: answer_text
#       )
#     end
#   end
#   puts "Response for the survey created"
# end

puts "Seed data creation complete!"