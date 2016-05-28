desc "pushes to both Github and Heroku"
task push: :environment do
  g = Git.init
  g.push('origin', 'master')
  g.push('heroku', 'master')
end

