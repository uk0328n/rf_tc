json.extract! event_detail, :id, :event_id, :advisor_id, :created_at, :updated_at
json.url event_detail_url(event_detail, format: :json)
