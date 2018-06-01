class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :common_preferences

  def age
    object.age(object.id)
  end

  def common_preferences
    object.common_preferences(object.id)
  end
end
