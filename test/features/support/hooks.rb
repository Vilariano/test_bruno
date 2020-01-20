#Tira screenshot da pagina
After do |scenario|
  scenario_name = scenario.name.gsub(/[^\w\-]/, ' ')

  if scenario.failed?
    # Se meu senario falhar tira um print e salva no caminho que defino em helper.rb
    page_screenshot(scenario_name.downcase!, 'falhou')
  else
    # Se meu senario falhar tira um print e salva no caminho que defino em helper.rb
    page_screenshot(scenario_name.downcase!, 'passou')
  end
end

Before "@EfetivarCompra" do
  select_prod.load
  expect(page).to have_content('Automation Practice Website')
   
  faz_login.log_automate
  expect(page).to have_content "AUTHENTICATION"
end