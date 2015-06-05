json.array!(@menus) do |menu|
  json.extract! menu, :id, :serve_date, :breakfast_time, :lunch_time, :dinner_time, :breakfast_head_count, :lunch_head_count, :dinner_head_count, :breakfast_recipe_ids, :dinner_recipe_ids, :lunch_recipe_ids
  json.url menu_url(menu, format: :json)
end
