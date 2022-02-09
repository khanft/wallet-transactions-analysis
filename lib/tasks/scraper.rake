namespace :scraper do
  desc "TODO"
  task etherscan: :environment do
    ScrapeEtherscanJob.perform_now
  end

end
