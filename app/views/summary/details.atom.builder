atom_feed do |feed|
  feed.title "UTU Details"
	@events.each do |event|
		feed.entry(event) do |entry|
		  entry.title event.title
		  entry.summary type: 'xhtml' do |xhtml|
		    xhtml.p event.description
		  end
		end
	end
end