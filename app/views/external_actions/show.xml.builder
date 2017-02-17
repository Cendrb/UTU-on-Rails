xml.instruct!
xml.utu do
  xml.status do
    xml.code(0)
    xml.message('Item based action successful')
  end

  render partial: '_generic_utu_partials/show.xml', locals: {item: @item, builder: xml}
end
