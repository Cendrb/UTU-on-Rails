namespace :vcs do
  desc "pushes to both Github and Heroku"
  task all: :environment do
    g = Git.init
    g.push('origin', 'master')
    g.push('heroku', 'master')
  end
end
