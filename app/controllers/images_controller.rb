class ImagesController < ApplicationController
  before_action :set_parent

    def destroy
      @parent.images.find(params[:id]).purge
      respond_to do |format|
        if @parent.is_a?(Card)
          format.html { redirect_to edit_card_path(@parent), notice: "Image was successfully destroyed." }
        elsif @parent.is_a?(Page)
          format.html { redirect_to edit_page_path(@parent), notice: "Image was successfully destroyed." }
        elsif @parent.is_a?(Candidate)
          format.html { redirect_to edit_candidate_path(@parent), notice: "Image was successfully destroyed." }
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
      elsif params[:candidate_id]
        @parent = Candidate.find(params[:candidate_id])
      end
    end
end
