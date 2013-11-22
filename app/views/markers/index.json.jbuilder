json.array!(@markers) do |marker|
  json.extract! marker, :first, :last, :email, :abbr, :scaling, :shift, :admin, :encrypted_password, :salt
  json.url marker_url(marker, format: :json)
end
