class CardsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show tagged]
  before_action :set_card, only: %i[ show edit update destroy ]

  # GET /cards or /cards.json
  def index
    @cards = Card.all
  end

  # GET /cards/1 or /cards/1.json
  def show
  end
  
  def tagged
    ids = params['id'].split('/')
    @tags = ids.map {|id| ActsAsTaggableOn::Tag.find(id.to_s)}
    names = @tags.map(&:name)
    @cards = Card.tagged_with(names)
    @all_tags = []
    @cards.each do |card|
      @all_tags << card.tags
    end
    @related_tags = @all_tags.flatten.uniq - @tags
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params)
    @card.images.attach(params[:images])
    
    respond_to do |format|
      if @card.save
        format.html { redirect_to card_url(@card), notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to card_url(@card), notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy!

    respond_to do |format|
      format.html { redirect_to cards_url, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def card_params
#       params.fetch(:card, {})
#     end
    
    def card_params
      # if current_admin
#         params.require(:poster).permit(:name, :email, :score, :image, :pdf, :place_list, :status)
#       else
        params.require(:card).permit(:title, :subtitle, :body, :location_list, :topic_list, :status_list, new_images: [])
      # end
    end
end
