# This file should contain all the record creation needed to seed
# the database with its default values.
# The data can then be loaded with the rails db:seed command
# (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all


users = User.create!([{user_name: 'Syrie'}, {user_name: 'Evelyn'}, {user_name: 'George'}])

poll1 = {title: "Cats", author_id: users.first.id }
poll2 = {title: "Dogs", author_id: users.second.id }

polls = Poll.create!([poll1, poll2])

question1 = {question: 'Do you like cats?', poll_id: polls.first.id}
question2 = {question: 'Do you like kittens?', poll_id: polls.first.id}
question3 = {question: 'Do you like big cats, such as lions?', poll_id: polls.first.id}
question4 = {question: 'Do you like dogs?', poll_id: polls.second.id}
question5 = {question: 'Do you like maltese?', poll_id: polls.second.id}

questions = Question.create!([question1, question2, question3, question4, question5])

answers = []

  5.times do |i|
    answers << {answer_choice: 'yes', question_id: questions[i].id}
    answers << {answer_choice: 'no', question_id: questions[i].id}
    answers << {answer_choice: 'maybe', question_id: questions[i].id}
  end

AnswerChoice.create!(answers)

syrie = users[0]
evelyn = users[1]
george = users[2]


response1 = {user_id: syrie.id, answer_choice_id: AnswerChoice.all.first.id}
response2 = {user_id: syrie.id, answer_choice_id: AnswerChoice.all.second.id}
response3 = {user_id: evelyn.id, answer_choice_id: AnswerChoice.all.first.id}
response4 = {user_id: evelyn.id, answer_choice_id: AnswerChoice.all.last.id}

responses = [response1, response2, response3, response4]

Response.create!(responses)
