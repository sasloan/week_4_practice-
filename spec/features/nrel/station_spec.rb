require 'rails_helper'

RSpec.describe 'As a User' do 
    describe 'When I visit the home page' do 
        it 'I can search for gas stations using the nrel api' do 

            visit '/'

            expect(current_path).to eq('/')

            # And I select "Turing" form the start location drop down (Note: Use the existing search form)
            select "Turing", from: :location

            # And I click "Find Nearest Station"
            click_on "Find Nearest Station"

            # Then I should be on page "/search"
            expect(current_path).to eq("/search")

            # Then I should see the closest electric fuel station to me.
            expect(page).to have_css(".station")

            # For that station I should see
            # - Name
            # - Address
            # - Fuel Type
            # - Access Times
            expect(page).to have_css("#name")
            expect(page).to have_css("#address")
            expect(page).to have_css("#fuel_type")
            expect(page).to have_css("#access_times")

            # I should also see:

            # - the distance of the nearest station (should be 0.1 miles)
            expect(page).to have_content("Distance of nearest station: 0.1 mi")

            # - the travel time from Turing to that fuel station (should be 1 min)
            expect(page).to have_content("Travel Time from 1331 17th St LL100, Denver, CO 80202: 1 min")

            # - The direction instructions to get to that fuel station
            #   "Turn left onto Lawrence St Destination will be on the left"
            expect(page).to have_content("Turn <b>left</b> onto <b>Lawrence St</b><div style=\"font-size:0.9em\">Destination will be on the left</div>")

        end
    end
end
