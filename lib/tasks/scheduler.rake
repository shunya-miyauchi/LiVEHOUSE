desc 'This task is called by the Heroku scheduler add-on'
task scraping: :environment do
  Scraping.execute
end
