xml.instruct!
xml.utu do
  xml.status do
    xml.code(0)
    xml.message('Only details fetch successful')
  end
  @data[:items].each do |item|
    render partial: '_generic_utu_partials/show.xml', locals: {item: item, builder: xml}
  end
end