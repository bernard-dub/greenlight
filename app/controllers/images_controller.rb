class ImagesController < ApplicationController
  before_action :set_card

    def destroy
      @card.images.find(params[:id]).purge
      respond_to do |format|
        format.html { redirect_to edit_card_path(@card), notice: "Image was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    def set_card
      @card = Card.find(params[:card_id])
    end
end
