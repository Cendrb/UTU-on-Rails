atom_feed do |feed|
  feed.title "UTU Details"
	@events.each do |event|
		feed.entry(event) do |entry|
		  entry.title event.title
		  entry.summary type: 'xhtml' do |xhtml|
		    xhtml.p event.description
		    xhtml.table do
		      xhtml.tr do
            xhtml.th "Místo: "
            xhtml.td event.location
          end
		      xhtml.tr do
		        xhtml.th "Počátek akce: "
		        xhtml.td l event.event_start
		      end
		      xhtml.tr do
            xhtml.th "Konec akce: "
            xhtml.td l event.event_end
          end
		      xhtml.tr do
            xhtml.th "Cena: "
            xhtml.td number_to_currency(event.price)
          end
          xhtml.tr do
            xhtml.th "Datum platby: "
            xhtml.td l event.pay_date
          end
          if event.additional_info_url
            xhtml.tr do
              xhtml.th "Další informace: "
              xhtml.td event.additional_info_url
            end
          end
		    end
		  end
		end
	end
end