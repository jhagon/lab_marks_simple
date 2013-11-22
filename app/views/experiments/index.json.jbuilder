json.array!(@experiments) do |experiment|
  json.extract! experiment, :title, :description
  json.url experiment_url(experiment, format: :json)
end
