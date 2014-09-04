json.array!(@rankings) do |ranking|
  json.extract! ranking, :id, :value, :comment, :assist, :driver, :user_id, :owner_id
  json.url ranking_url(ranking, format: :json)
end
