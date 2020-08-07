require 'selenium-webdriver'
require 'rest-client'
require 'rspec'

RSpec.describe "Google API/UI Tests" do
  context "UI tests" do

    before(:all) do
      @driver = Selenium::WebDriver.for :chrome
      @driver.get('https://www.google.co.nz')
      @driver.manage.window.maximize
      @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    end

    it "Validate that search predictions pop up on typing query in the search bar" do
      @wait.until {@driver.find_element(:name, 'q')}
      search_bar = @driver.find_element(:name, 'q')
      search_bar.send_keys "Sample"
      expect(@driver.find_element(:xpath, '//*[@id="tsf"]//*//ul').displayed?).to eq(false)
    end

    it "Validate that user is able to clear the inputs from the search bar" do
      @wait.until {@driver.find_element(:xpath, "//*[contains(@class,'clear-button')]")}
      clr_btn = @driver.find_element(:xpath, "//*[contains(@class,'clear-button')]")
      clr_btn.click
      @wait.until {@driver.find_element(:name, 'q')}
      search_bar = @driver.find_element(:name, 'q')
      expect(search_bar.text).to eq('')
    end

    it "Validate that user is able to search using text input" do
      @wait.until {@driver.find_element(:name, 'q')}
      search_bar = @driver.find_element(:name, 'q')
      search_bar.send_keys "Sample"
      @wait.until {@driver.find_elements(:xpath, "//*[contains(@value,'Google Search')]")}
      search_btn = @driver.find_elements(:xpath, "//*[contains(@value,'Google Search')]")[1]
      @driver.action.key_down(:escape).key_up(:escape).perform
      search_btn.click
      @wait.until {@driver.find_element(:id, 'rso')}
      expect(@driver.find_element(:id, 'rso').displayed?).to eq(true)
    end

    after(:all) do
      @driver.quit
    end
  end

  context "API tests" do
    it "Validate that Google search page is reachable" do
      response = RestClient.get("https://www.google.co.nz")
      expect(response.code).to eq 200
    end

    it "Validate that user is able to search using text" do
      response = RestClient.get("https://www.google.co.nz/search?q=sample")
      expect(response.code).to eq 200
      expect(response.body).to include("a sound or piece of music created by sampling")
    end

    it "Validate that user is unable to search with empty query" do
      response = RestClient.get("https://www.google.co.nz/search?q=")
      expect(response.code).to eq 200
      # Validating that user stays on the Google Search home page
      expect(response.body).to include("I'm Feeling Lucky")
    end
  end
end