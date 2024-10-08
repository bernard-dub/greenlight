class CardsController < ApplicationController
  # before_action :authenticate_user!, except: %i[index show tagged like unlike]
  before_action :auth_user, except: %i[index to_print show tagged like unlike]
  before_action :set_card, only: %i[show edit update destroy like unlike ]
  before_action :set_likes, only: %i[index to_print tagged show create update comments ]
  

  # GET /cards or /cards.json
  def index
    @cards = user_signed_in? ? Card.all.by_weight : Card.published.by_weight
    @pages = user_signed_in? ? Page.all : Page.published
  end
  
  def to_print
    index
    render
  end

  # GET /cards/1 or /cards/1.json
  def show
  end
  
  def tagged
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
  
  def comments
    @cards = Card.by_comment
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
    authenticate_user!
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
  
  def import_data
    ods = Roo::OpenOffice.new(Rails.root.join('lib', 'assets', 'import_20240615.ods'))
    ods.sheet(0).each_with_index(title: 'Titre', subtitle: 'Sous-titre', body: 'Corps_de_texte',
                                 locations: 'lieux', topics: 'thèmes', statuses: 'statut') do |row, row_index|                           
      next if row_index == 0 || row[:title].blank?
      # logger.debug "********* locations : #{row[:topics]}"
     card = Card.find_or_create_by(title: row[:title])
     card.update( title: row[:title],
                  subtitle: row[:subtitle],
                  body: row[:body],
                  location_list: row[:locations],
                  topic_list: row[:topics],
                  status_list: row[:statuses])
    end
  end
  
  def delete_likes_cookies
    cookies.encrypted[:likes] = nil
    redirect_to cards_url
  end
  
  def like
    likes = cookies.encrypted[:likes].blank? ? [] : JSON.parse(cookies.encrypted[:likes])
    respond_to do |format|
      if !likes.include?(@card.id) && @card.update(score: @card.score+1)
        likes.append(@card.id)
        @likes = likes
        cookies.encrypted[:likes] = JSON.generate(likes)
        format.html { render partial: 'like_button', locals: {card: @card}, layout: false }
        format.json { render :list, status: :ok }
      else
         format.html { head :bad_request }
         format.json { head :bad_request }
      end
    end
  end
  
  def unlike
    likes = cookies.encrypted[:likes].blank? ? [] : JSON.parse(cookies.encrypted[:likes])
    respond_to do |format|
      if likes.include?(@card.id) && @card.update(score: @card.score-1)
        likes.delete(@card.id)
        @likes = likes
        cookies.encrypted[:likes] = JSON.generate(likes)
        format.html { render partial: 'like_button', locals: {card: @card}, layout: false }
        format.json { render :list, status: :ok }
      else
        format.html { head :bad_request }
        format.json { head :bad_request }
      end
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end
    
    def set_likes
      @likes = cookies.encrypted[:likes].blank? ? [] : (JSON.parse(cookies.encrypted[:likes]))
    end
    

    # Only allow a list of trusted parameters through.
    # def card_params
#       params.fetch(:card, {})
#     end
    
    def card_params
      # if current_admin
#         params.require(:poster).permit(:name, :email, :score, :image, :pdf, :place_list, :status)
#       else
        params.require(:card).permit(:title, :subtitle, :body, :location_list, :topic_list, :status_list, :weight, :score, :published, :comment, page_ids: [], candidate_ids: [], new_images: [])
      # end
    end
end
