load "scripts/etherscan.rb"

class ScrapeEtherscanJob < ApplicationJob

  queue_as :default

  def perform(*args)
    ScrapableAddress.all.each do |address|
      puts "alalalal #{address.address}"
      begin 
        eapi = EtherscanAPI.new address.address
        eapi.parse_all
      rescue Exception => e 
        puts "Error scraping #{e}"
      end
    end
  end
end
