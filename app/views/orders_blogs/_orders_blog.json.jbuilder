json.extract! orders_blog, :id, :action, :created_at, :updated_at
json.url orders_blog_url(orders_blog, format: :json)