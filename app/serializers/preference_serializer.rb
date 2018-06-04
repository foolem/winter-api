class PreferenceSerializer < ActiveModel::Serializer
  attributes :id, :creator_id, :area_id, :sub_area_id, :content

  def area_id
    object.sub_area.area_id
  end

end
