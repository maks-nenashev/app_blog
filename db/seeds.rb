 30.times do
   title = Faker::Hipster.sentence(word_count: 3)
   text = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
   Article.create title: title, text: text
 end
