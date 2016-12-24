json.extract! order, :id, :start_point, :end_point, :comment, :created_at, :updated_at
json.url order_url(order, format: :json)