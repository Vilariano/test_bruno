require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'report_builder'
require 'faker'
require 'cpf_faker'


require_relative 'helper.rb' ## Arquivo com chamada para print(scheenshot)
require_relative 'page_helper.rb' ##Arquivo que inicia todas as minhas classes

World Capybara::DSL
World Capybara::RSpecMatchers

World Page
World Helper

BROWSER = ENV['BROWSER'] ##tagueamento para escolha de Browsaer
AMBIENTE = ENV['AMBIENTE'] ##tagueamento para escolha de Ambiante

CONFIG = YAML.load_file(File.dirname(__FILE__) + "/ambientes/#{AMBIENTE}.yml") ## Caminho de arquivo com definiçoes de ambiente

## executa navegador de acordo com o navegador escolhido em cucumber.yml
# :selenium_headless, :selenium_chrome, :selenium_chrome_headless
case BROWSER
when "chrome"
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.args << '--disable-site-isolation-trials'
      opts.args << '--start-maximized'
      opts.args << '--incognito'
    end
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
  end
  @driver = :selenium_chrome
when "chrome_headless"
  Capybara.register_driver :selenium_chrome_headless do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.args << '--headless'
      opts.args << '--disable-gpu' if Gem.win_platform?
      opts.args << '--no-sandbox'
      opts.args << '--incognito'
      opts.args << '--window-size=1200x680'
      opts.args << '--disable-site-isolation-trials'
    end
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: browser_options
    )
  end
  @driver = :selenium_chrome_headless
else
  puts "Invalid browser"
end

ReportBuilder.configure do |config|
  config.json_path = "results/report.json" #pasta onde salva o json
  config.report_path = "results/report" #pasta onde salva o html
  config.report_types = [:html] #tipo de report a exportar
  config.report_title = "Report de testes" #nome do report
  config.color = "blue" #cor do report
  config.include_images = true #se coloca imagens ou não
  config.additional_info = { browser: ENV['BROWSER'], ambiente: CONFIG['ambiente'], user: CONFIG['user']} 
end
#essa variável ambiente recebe uma configuração do ENV. voce pode apagar os IFs ali e deixar o nome chumbado
at_exit do
  ReportBuilder.build_report
end

Capybara.configure do |config|
  config.default_driver = @driver ## Variavel para definissão de Browser
  config.app_host = CONFIG['url_padrao'] ## Parametro para escolha de Ambiente
  config.default_max_wait_time = 25 ## Time global de espera
end