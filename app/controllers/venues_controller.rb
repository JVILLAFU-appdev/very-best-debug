class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list.html.erb" })
  end

  def show
    venue_id = params.fetch("an_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.first

    render({ :template => "venue_templates/details.html.erb" })
  end

  def create
    #Parameters: {"query_address"=>"60601 E", "query_name"=>"PUBY", "query_neighborhood"=>"LONG"}
    venue = Venue.new
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save

    redirect_to("/venues/"+ venue.id.to_s)

  end
  
  def update
    the_id = params.fetch("the_id")

    #Parameters: {"query_address"=>"vf", "query_name"=>"vfffg", "query_neighborhood"=>"vgghf"}

    venue = Venue.where({ :id => the_id }).first
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save
    
    redirect_to("/venues/"+ venue.id.to_s)
  end

  def destroy
    the_id = params.fetch("id_to_delete")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.first
    venue.destroy

    redirect_to("/venues")
  end

end
