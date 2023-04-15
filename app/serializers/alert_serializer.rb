class AlertSerializer
  include FastJsonapi::ObjectSerializer
  attributes :price, :status, :user_id
end
