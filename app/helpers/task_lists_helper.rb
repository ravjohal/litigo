module TaskListsHelper
  def select_anchor_date_options
    arr = []
    TaskDraft::ANCHOR_DATE_HASH.each do |key, val|
      val.each do |k,v|
        arr.push([v, "#{key}.#{k}"])
      end
    end
    arr
  end
  def select_before_anchor_date_options
    arr = []
    TaskDraft::ANCHOR_DATE_HASH.each do |key, val|
      val.each do |k,v|
        arr.push([v, "#{key}.#{k}"]) unless ['affair.created_at', 'lead.created_at', 'incident.incident_date'].include?("#{key}.#{k}")
      end
    end
    arr
  end
  module_function :select_anchor_date_options
  module_function :select_before_anchor_date_options
end
