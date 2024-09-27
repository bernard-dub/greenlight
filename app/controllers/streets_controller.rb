class StreetsController < ApplicationController
  before_action :auth_user, except: %i[show to_print]
  
  def show
    @street = Street.find(params[:id])
    @tags = []
    @cards = @street.cards
  end

  def index
    @streets = {}
    @locations = ActsAsTaggableOn::Tag.for_context(:locations)
    @locations.map do |location|
      @streets[location] = Street.tagged_with(location)
    end
  end

  def edit
    @street = Street.find(params[:id])
  end
  
  def update
    @street = Street.find(params[:id])
    @street.parent_id = params[:parent_id] || nil
    respond_to do |format|
      if @street.update(street_params)
        format.html { redirect_to street_url(@street), notice: "Street was successfully updated." }
        format.json { render :show, status: :ok, location: @street }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cstreet.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
  end
  
  def cards_tagged
    @street = Street.find(params[:street_id])
    ids = params['id'].split('/')
    @tags = ids.map {|id| ActsAsTaggableOn::Tag.find(id.to_s)}
    names = @tags.map(&:name)
    @cards = Card.published.tagged_with(names).by_weight
    @all_tags = {:locations => [], :topics => [], :statuses => []}
    @cards.each do |card|
      @all_tags[:locations] << card.locations.most_used
      @all_tags[:topics] << card.topics.most_used
      @all_tags[:statuses] << card.statuses.most_used
    end
    @related_tags = {}
    @related_tags[:locations] = @all_tags[:locations].flatten.uniq - @tags
    @related_tags[:topics] = @all_tags[:topics].flatten.uniq - @tags
    @related_tags[:statuses] = @all_tags[:statuses].flatten.uniq - @tags
  end
  
  def add_card
    @street = Street.find(params[:street_id])
    @card = Card.find(params[:card_id])
    @street.cards << @card
    @cards = @street.related_cards
    render partial: 'related_cards'
  end
  
  def remove_card
    @street = Street.find(params[:street_id])
    @card = Card.find(params[:card_id])
    @street.cards.delete @card
    @cards = @street.related_cards
    render partial: 'related_cards'
  end
  
  def import_data
    ods = Roo::OpenOffice.new(Rails.root.join('lib', 'assets', 'import_streets.ods'))
    ods.sheet(0).each_with_index(location: 'location', name: 'name', position: 'position',
                                 houses: 'houses') do |row, row_index|                           
      next if row_index == 0 || row[:name].blank?
      # logger.debug "********* locations : #{row[:topics]}"
     street = Street.find_or_create_by(name: row[:name])
     street.update( name: row[:name],
                  position: row[:position],
                  houses: row[:houses],
                  location_list: row[:location])
    end
  end
  
  private
  
    def street_params
        params.require(:street).permit(:name, :integrated_name, :body, :position, :houses, :location_list, :status, :parent_id, card_ids: [])
    end
end
