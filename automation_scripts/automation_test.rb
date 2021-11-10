# Scratch file for writing and running short scripts.
# This was to quickly fill the database with article entries so I could test
# CSS element positions on long scrolling pages.

require('../config/environment.rb')

i = 0
cycles = 30

cycles.times do
  article = Article.new(
    title: "Aw shit here we go again #{i} of #{cycles}",
    description: "AAHH AAHHH AAAAHHH AHH",
    user: User.first
  )
  # So we will save the article, unless there are errors that prevent us from doing so,
  # in which case print the errors so I can fix the test script and run again.
  puts article.errors.full_messages unless article.save
  i += 1
end
