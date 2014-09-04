json.array!(@buses) do |bus|
  json.extract! bus, :id, :bus_id, :patente, :empresa_id, :asientos, :tipo
  json.url bus_url(bus, format: :json)
end
