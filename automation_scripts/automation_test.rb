# Scratch file for writing and running short scripts.
# This was to quickly fill the database with article entries so I could test
# CSS element positions on long scrolling pages.

require('../config/environment.rb')

i = 0
num = 15

while i < num do
  article = Article.new(title: "Message from monke #{i} of #{num}", description: "AAHH AAHHH AAAAHHH AHH")
  article.save
  i += 1
end