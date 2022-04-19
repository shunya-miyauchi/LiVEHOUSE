namespace :scheduler do
  desc 'This task is called by the Heroku scheduler add-on'
  task scraping: :environment do
    Scraping::SpotifyOnest.execute
    Scraping::Basementbar.execute
  end
end
