require "spec_helper"

describe IncidentsController, type: :controller do
  describe "GET show" do

    let(:case_var) { FactoryGirl.create(:case_with_incident) }
    let(:incident) { case_var.incident }
    let!(:firm) {FactoryGirl.create(:firm)}

    it "has a 200 status code" do
      sign_in
      # binding.pry
      get :show, id: case_var.incident.id, case_id: case_var.id
      expect(response.status).to eq(200)
    end

    it "blocks unauthenticated access and gives 302 status code when user is not signed in" do
      sign_in nil
      get :show, id: case_var.incident.id, case_id: case_var.id
      expect(response.status).to eq(302)
    end

    it "renders the :show template" do
      sign_in
      get :show, id: case_var.incident, case_id: case_var
      expect(response).to render_template("show")
    end

    it "assigns the requested incident to @incident" do
      sign_in
      get :show, id: case_var.incident, case_id: case_var
      expect(assigns(:incident)).to eq(incident)
    end

    it "assigns the requested case to @case" do
      sign_in
      get :show, id: case_var.incident.id, case_id: case_var.id
      expect(assigns(:case)).to eq(case_var)
    end
  end
end