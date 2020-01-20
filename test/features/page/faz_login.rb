class FazLoginPage < SitePrism::Page
  element :sign_in, 'a.login'

  def log_automate
    sign_in.click
  end
end