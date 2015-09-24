class AddContactRelationToInsurancesPolicyHolder < ActiveRecord::Migration

  def up
    add_column :insurances, :policy_holder_id, :integer
    add_index :insurances, :policy_holder_id

    Insurance.where('policy_holder != \'\'').find_each do |insurance|
      f_name, l_name = insurance.policy_holder.to_s.strip.split(' ')
      _case = insurance.case
      _contact = _case.contacts.where(:first_name => f_name, :last_name => l_name).exists? ?
          _case.contacts.select(:id).where(:first_name => f_name, :last_name => l_name).first :
          _case.firm.contacts.create({ first_name: f_name, last_name: l_name, type: 'Defendant', firm_id: _case.firm_id })
      insurance.update(:policy_holder_id => _contact.id)
    end
    remove_column :insurances, :policy_holder
  end

  def down
    add_column :insurances, :policy_holder, :string
    Insurance.where('policy_holder_id > 0').find_each do |insurance|
      insurance.update(:policy_holder => insurance.policy_holder_contact.name)
    end
    remove_index :insurances, :policy_holder_id
    remove_column :insurances, :policy_holder_id
  end

end
