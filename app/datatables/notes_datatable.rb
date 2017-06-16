class NotesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  include ActionView::Helpers::TagHelper
  include DatesHelper

  def initialize(view, user, user_notes, case_notes, case_)
    @view = view
    @user = user
    @firm = @user.firm
    @user_notes = user_notes
    @case_notes = case_notes
    @case = case_
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: notes.count(:all),
        iTotalDisplayRecords: notes.count(:all),
        aaData: data
    }
  end

  private

  def data
    notes.map do |one_note|
      [
          one_note.case.try(:name),
          one_note.user.try(:name),
          link_to(one_note.note, one_note),
          simple_format_date_regexp(one_note.created_at),
          one_note.note_type
      ]
    end
  end

  def notes
    @notes ||= fetch_notes
  end

  def fetch_notes
    #puts " WHAT IS USER NOTES  " + @user_notes.to_s + " " + @case_notes.to_s
    #fetch_model = @user_cases ? @user : @firm
    if @user_notes && !@case_notes # my /notes
      notes = @user.notes.includes(:case).order("created_at desc") #.send(params[:notesScope])
      #puts "MY NOTES"
    elsif @user_notes && @case_notes # my /case/:id/notes
      notes = @case.notes.where(:user => @user) #.send(params[:notesScope])
      #notes += @case.notes.joins(:notes_users).where('notes_users.secondary_owner_id = ?', @user.id)
      puts " MY CASE NOTES" + notes.inspect
    elsif !@user_notes && @case_notes # all /case/:id/notes
      notes = @case.notes.order("created_at desc") #.send(params[:notesScope])
      puts " ALL CASE NOTES " + notes.inspect
    else # all /notes
      notes = @firm.notes.includes(:case).order("created_at desc") #.send(params[:notesScope])
      # puts " ALL NOTES " + params[:notesScope].to_s
    end
      

    if params[:iSortCol_0].to_i == 1
      # cases = cases.joins(:medical).order("total_med_bills #{sort_direction}")
      notes = notes.order("created_at #{sort_direction}")
    elsif params[:iSortCol_0].to_i == 2
      notes = notes.order("note_type #{sort_direction}")
    else
      notes = notes.order("#{sort_column} #{sort_direction}")
    end
    notes = notes.page(page).per_page(per_page)
    if params[:sSearch].present?
      notes = notes.search_note(params[:sSearch])
    end
    notes
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[created_at note note_type]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end