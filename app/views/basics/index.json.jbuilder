json.array!(@basics) do |basic|
  json.extract! basic, :id
  json.url basic_url(basic, format: :json)
end
