module GenericUtuItems
  extend ActiveSupport::Concern

  def new_init(object)
    params[:additional_infos] = {}
  end

  def edit_init(object)
    params[:additional_infos] = {}
    object.info_item_bindings.each do |item|
      params[:additional_infos][item.additional_info.id] = 1
    end
  end

  def update_init(object)
    object.info_item_bindings.destroy_all
    params[:additional_infos].each do |checkbox|
      object.info_item_bindings << InfoItemBinding.create(item_id: object.id, item_type: object.get_utu_type, additional_info_id: checkbox[0].to_i)
    end
  end
end