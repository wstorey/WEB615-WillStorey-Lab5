for i in 1..50
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  name = "#{first_name} #{last_name}"
  email = Faker::Internet.safe_email(name)

  user = User.new
  user.name = name
  user.email = email
  if user.save
    p "Saved User ##{i}: #{name} (#{email})"
    for ii in 1..50
      article = Article.new
      article.user = user
      article.title = Faker::Lorem.word
      article.content = Faker::Lorem.paragraph
      if article.save
        p "Article ##{ii}: saved for #{name}"
        for iii in 1..10
          comment = Comment.new
          comment.user = user
          comment.article = article
          comment.message = Faker::Lorem.paragraph
          comment.created_at = Faker::Date.backward(3)
          if comment.save
            p "Comment ##{iii} saved for #{article.title}"
          else
            p comment.errors
          end
        end
      else
        p article.errors
      end
    end
  else
    p user.errors
  end

end