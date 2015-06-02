json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :name, :serving_size
  json.url recipe_url(recipe, format: :json)
end
