require 'spec_helper'

describe Task do

  let!(:user) { create(:user) }
  let!(:cas) { create(:case, number: 7, case_type: 'CType', subtype: 'SubType', name: 'Case1',
                      description: 'Description') }

  let!(:task) { create(:task, name: 'Task1', due_date: Date.today, completed: Date.today, sms_reminder: true,
                       email_reminder: true, description: 'Descr', user: user) }

  context 'Check attributes' do
    it 'Expects Task to be valid and have attrs' do
      expect(task.name).to eq 'Task1'
      expect(task.due_date).to eq Date.today
      expect(task.completed).to eq Date.today
      expect(task.sms_reminder).to eq true
      expect(task.email_reminder).to eq true
      expect(task.description).to eq 'Descr'
    end

    it 'Expects to have user' do
      expect(task.user).to eq user
    end

  end

  context 'Checking dependencies' do

    it 'Expects to have has_and_belongs_to_many Case -> Event association' do
      cas.tasks << task
      expect(cas.tasks.size).to eq 1
      expect(cas.tasks.first).to eq task

    end
  end
end
