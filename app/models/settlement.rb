class Settlement < ActiveRecord::Base

  belongs_to :firm
  belongs_to :case
  belongs_to :user, class_name: 'User', foreign_key: 'created_by_id'
  belongs_to :template

  before_save :update_template

  def html_content
    return template.html_content if template

    template = Template.new
    template.user = user
    template.firm = firm

    File.open(Rails.root.join('lib/settlement.html')) do |f|
      template.html_content = f.read
    end
    template.description = 'settlement Sheet Template'
    template.name = 'settlement Sheet Template'

    template.html_content
  end

  def fill_generated_html
    html = Nokogiri::HTML(html_content.html_safe)
    html.css(".insertion").each do |span|
      case span['data-model']
        when 'Firm'         then span.inner_html = firm.send(span['data-attr'])
        when 'Plaintiff'    then span.inner_html = self.case.plantiff_contacts.first.contact.try(:send, span['data-attr']) if self.case.plantiff_contacts.first
        when 'Attorney'     then span.inner_html = self.case.attorney_contacts.first.contact.try(:send, span['data-attr']) if self.case.attorney_contacts.first
        when 'Case'
          case span['data-attr']
            when 'close_date'     then span.inner_html = self.case.closing_date.try(:strftime, '%m/%d/%Y').to_s
            when 'total_expenses' then span.inner_html = ActionController::Base.helpers.number_to_currency self.case.expenses.to_a.sum(&:amount).to_f
            when 'total_owed'     then span.inner_html = ActionController::Base.helpers.number_to_currency self.case.medical_bills.to_a.sum(&:total_billed_adjustment_paid_amounts)
            when 'subro_paid'     then span.inner_html = ActionController::Base.helpers.number_to_currency Insurance.total_amount_paid(self.case)
          end
        when 'Resolution'
          case span['data-attr']
            when 'amount' then span.inner_html = ActionController::Base.helpers.number_to_currency self.case.resolution.try(:amount).to_f
          end
        when 'Calculation'
          case span['data-attr']
            when 'con_fee_res_amount'
              span.inner_html = ActionController::Base.helpers.number_to_currency(self.case.resolution.try(:amount).to_f * 0.33)
            when 'res_amount_att_fee'
              span.inner_html = ActionController::Base.helpers.number_to_currency(self.case.resolution.try(:amount).to_f - (self.case.resolution.try(:amount).to_f * 0.33))
            when 'res_amount_att_fee_total_exp'
              span.inner_html = ActionController::Base.helpers.number_to_currency(self.case.resolution.try(:amount).to_f - (self.case.resolution.try(:amount).to_f * 0.33) - self.case.expenses.to_a.sum(&:amount).to_f)
            when 'res_amount_att_fee_total_exp_net_owed'
              span.inner_html = ActionController::Base.helpers.number_to_currency(self.case.resolution.try(:amount).to_f - (self.case.resolution.try(:amount).to_f * 0.33) - self.case.expenses.to_a.sum(&:amount).to_f - self.case.medical_bills.to_a.sum(&:total_billed_adjustment_paid_amounts))
            when 'res_amount_att_fee_total_exp_net_owed_subro_paid'
              span.inner_html = ActionController::Base.helpers.number_to_currency(self.case.resolution.try(:amount).to_f - (self.case.resolution.try(:amount).to_f * 0.33) - self.case.expenses.to_a.sum(&:amount).to_f - self.case.medical_bills.to_a.sum(&:total_billed_adjustment_paid_amounts) - Insurance.total_amount_paid(self.case))
          end
        when 'for'
          case span['data-for']
            when 'expense'
              self.case.expenses.to_a.each do |expense|

                new_span = Nokogiri::XML::Node.new('span', html)
                new_span['style'] = 'text-align: center;'
                new_span.inner_html = "#{expense.created_date.try(:strftime, '%m/%d/%Y')} #{expense.description} #{ActionController::Base.helpers.number_to_currency expense.amount.to_f}"

                new_row = Nokogiri::XML::Node.new('p', html)
                new_row['class'] = 'columns left_column'
                new_row['style'] = 'font-size:11pt;'
                new_row.add_child(new_span)
                span.after(new_row)
              end
              span.remove
            when 'medical_bill'
              self.case.medical.try(:medical_bills).to_a.each do |medical_bill|
                new_span = Nokogiri::XML::Node.new('span', html)
                new_span['style'] = 'text-align: center;'
                new_span.inner_html = "#{medical_bill.provider} #{medical_bill.services} #{ActionController::Base.helpers.number_to_currency medical_bill.total_billed_adjustment_paid_amounts.to_f}"

                new_row = Nokogiri::XML::Node.new('p', html)
                new_row['class'] = 'columns left_column'
                new_row['style'] = 'font-size:11pt;'
                new_row.add_child(new_span)
                span.after(new_row)
              end
              span.remove
            when 'insurance'
              self.case.insurance.try(:children).to_a.each do |insurance|
                new_span = Nokogiri::XML::Node.new('span', html)
                new_span['style'] = 'text-align: center;'
                new_span.inner_html = "#{insurance.company.try(:name)} #{ActionController::Base.helpers.number_to_currency insurance.amount_paid.to_f}"

                new_row = Nokogiri::XML::Node.new('p', html)
                new_row['class'] = 'columns left_column'
                new_row['style'] = 'font-size:11pt;'
                new_row.add_child(new_span)
                span.after(new_row)
              end
              span.remove
          end
      end
    end
    html.to_html
  end

  private
    def update_template
      template.save if template
    end

end