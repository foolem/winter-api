class UserMatchSerializer < ActiveModel::Serializer
  attributes :id, :matched_user_name, :matched_user_id
end
