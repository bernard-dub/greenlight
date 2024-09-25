class StreetsController < ApplicationController
  before_action :auth_user, except: %i[show to_print]
  
  def show
    @street = Street.find(params[:id])
  end

  def index
    @streets = {}
    @locations = ActsAsTaggableOn::Tag.for_context(:locations)
    @locations.map do |location|
      @streets[location] = Street.tagged_with(location)
    end
  end

  def edit
  end

  def delete
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
        params.require(:street).permit(:name, :integrated_name, :position, :houses, :location_list, :status, :parent_id, card_ids: [])
    end
end
