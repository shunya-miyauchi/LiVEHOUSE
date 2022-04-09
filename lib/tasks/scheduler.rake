namespace :scheduler do
  desc 'This task is called by the Heroku scheduler add-on'
  task scraping: :environment do
    OnestScraping.execute
    BasementbarScraping.execute
  end
end
