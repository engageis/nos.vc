MoIP.setup do |config|
  config.token = Configuration[:moip_token] or ''
  config.key = Configuration[:moip_key] or ''

  # Temp
  config.uri = "https://desenvolvedor.moip.com.br/sandbox"
end
