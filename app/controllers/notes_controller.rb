class NotesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :set_user  

  # GET /notes
  # GET /notes.json
  def index
    @user = current_user

    if get_case
      @notes = @case.notes
      @new_path_notes = new_case_note_path(@case)
      @notes_a = [@case, Note.new] #for modal partial rendering
    else
      @notes = @user.notes.order("created_at desc")
      @new_path_notes = new_note_path
      @notes_a = Note.new #for modal partial rendering
    end

    if params[:order] && ["asc", "desc"].include?(params[:sort_mode])
      order = params[:order].split(",").map {|o| "#{o} #{params[:sort_mode]}" }.join(", ")
      if params[:order] == 'case'
        @notes = @notes.order("case_id #{params[:sort_mode]}")
        logger.info"@notes: #{@notes}\n\n\n"
      else
        @notes = @notes.order(order)
      end
    end
    if params[:search].present? && params[:utf8] == "✓"
      logger.info"#{params[:search]}"
      @notes = @notes.search(params[:search])

    end
    @notes = @notes.paginate(:per_page => 10, :page => params[:page])
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
   
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit

  end

  # POST /notes
  # POST /notes.json
  def create
    
    if get_case
      @note = @case.notes.build(note_params)
    else
      @note = Note.new(note_params)
    end

    @note.user = @user
    
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    @user = current_user
    @note.user = @user
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @user = current_user
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:note, :case_id, :user_id, :note_type, :created_at, :updated_at, :author)
    end
end
