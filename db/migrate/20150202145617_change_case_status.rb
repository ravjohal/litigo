class ChangeCaseStatus < ActiveRecord::Migration
  def change
    Case.all.each do |one_case|
      if one_case.status
        if one_case.status.downcase  == 'open'
          one_case.status = 'negotiation'
        elsif one_case.status.downcase == 'pending'
          one_case.status = 'litigation'
        end
      else
        one_case.status = 'negotiation'
      end
      one_case.save!
    end
  end
end
