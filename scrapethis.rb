require 'kimurai'
require 'webdrivers'
require 'pry-byebug'
require 'nokogiri'

class InsuranceScraper < Kimurai::Base
  @name           = 'Insurance scraper'
  @start_urls     = ['https://queplan.cl/Comparar/Seguros-de-Salud']
  @engine         = :selenium_chrome
  # @engine         = :poltergeist_phantomjs
  @config = {
    user_agent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36',
    window_size: [1366, 2000]
  }

  @@jobs = []

  def scrape_page
    sleep 15
    # Scroll Until it reaches the end.
    browser.execute_script('window.scrollBy(0,10000)')
    sleep 15

    # take a screenshot of the page
    browser.save_screenshot

    doc = browser.current_response
    # card = doc.css('.card-insurance-container').first.css('.info-insurance > div')

    insurance_divs = doc.search('.card-insurance-container')
    insurance_divs.each do |insurance_div|
      # binding.pry
       begin
        carrier    = insurance_div.css('picture').first['title'].gsub(/(Logo|-|Comparador|Seguros|de|Salud)/, '').strip
        price      = insurance_div.css('.price-value').text.gsub('$', '').to_f
        coverage   = insurance_div.css('.info-insurance > div')[3].text.gsub('Cobertura ', '').strip.to_i
        max_amount = insurance_div.css('.info-insurance > div')[1].text.gsub(/(Tope|UF)/, '').strip.to_i
        deductible = insurance_div.css('.info-insurance > div')[2].text.gsub(/(Deducible )|(UF )/, '').strip.to_i
        job = [carrier, price, max_amount, deductible, coverage]
        @@jobs << job unless @@jobs.include?(job)
        rescue => exception
       end
    end
  end

  def parse(response, url:, data: {})
    # scrape first page
    scrape_page
    # next page link starts with 20 so the counter will be initially set to 2
    # num = 2

    # visit next page and scrape it
    10.times do
      # browser.visit("https://queplan.cl/Comparar/Seguros-de-Salud#{num}0")
      # num += 1

      browser.find('//a[@aria-label="Siguiente page"]').click
      puts "🔹 🔹 🔹 CURRENT NUMBER OF JOBS: #{@@jobs.count}🔹 🔹 🔹"
      puts "🔺 🔺 🔺 🔺 🔺  CLICKED NEXT BUTTON 🔺 🔺 🔺 🔺 "
      scrape_page
    end

    File.open("jobs.json","w") do |f|
      f.write(JSON.pretty_generate(@@jobs))
    end

    CSV.open('jobs.csv', 'w') do |csv|
      @@jobs.each do |job|
        csv << job
      end
    end
    @@jobs
  end
end

InsuranceScraper.crawl!
