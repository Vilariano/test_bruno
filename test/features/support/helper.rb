# metodo para tira screenshot e imbutir no relatorio html
module Helper
  def page_screenshot(file_name, resultado)
    data = Time.now.strftime('%F').to_s
    h_m_s = Time.now.strftime('%H%M%S%p').to_s
    temp_shot = page.save_screenshot("results/#{data}/temp_screen#{h_m_s}.png")
    shot = Base64.encode64(File.open(temp_shot, "rb").read)
    embed(shot, 'image/png', "Ver_Evidencia(#{data} - #{h_m_s})")
  end
end
