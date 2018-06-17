json.array!(@food_histories) do |food_history|
  json.extract! food_history, :id, :title, :detail
  json.url food_history_url(food_history, format: :json)
end
