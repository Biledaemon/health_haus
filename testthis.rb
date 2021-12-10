require 'kimurai'
require 'webdrivers'
require 'pry-byebug'
require 'nokogiri'

class InsuranceScraper < Kimurai::Base
  @name           = 'Insurance scraper'
  @start_urls     = ['https://www.healthcare.gov/see-plans/#/']
  @engine         = :selenium_chrome

  def parse(response, url:, data: {})
    puts 'Zip Code? '
    item = gets.chomp
    url = 'https://www.healthcare.gov/see-plans/#/search?q=#{item}'
    binding.pry
    # begin
    #   scrape_page
    # rescue
    #   #... error handler
    # else
    #   #... executes when no error
    # ensure
    #   browser.save_screenshot
    # end
  end
end

InsuranceScraper.crawl!
