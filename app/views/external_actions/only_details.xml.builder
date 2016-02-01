xml.instruct!
xml.utu do
  @data[:items].each do |item|
    render partial: '_generic_utu_partials/show.xml', locals: {item: item, builder: xml}
  end
end