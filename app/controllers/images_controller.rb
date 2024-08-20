class ImagesController < ApplicationController
  before_action :set_parent

    def destroy
      @parent.images.find(params[:id]).purge
      respond_to do |format|
        if @parent.is_a?(Card)
          format.html { redirect_to edit_card_path(@parent), notice: "Image was successfully destroyed." }
        else
          format.html { redirect_to edit_page_path(@parent), notice: "Image was successfully destroyed." }
        end
        format.json { head :no_content }
      end
    end

    private

    def set_parent
      if params[:card_id]
        @parent = Card.find(params[:card_id])
      elsif params[:page_id]
        @parent = Page.find(params[:page_id])
      end
    end
end
