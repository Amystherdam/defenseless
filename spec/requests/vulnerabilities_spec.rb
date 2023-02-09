require 'rails_helper'

RSpec.describe "/vulnerabilities", type: :request do

  let(:user) { create(:user) }

  let(:valid_attributes) {
    {
      name: "Vulnerabilidade",
      description: "Vulnerabilidade aleatória",
      impact: 0,
      solution: "Solução da Vulnerabilidade",
      status:0,
      user_id: user.id
    }
  }

  let(:invalid_attributes) {
    {
      name: "Vulnerabilidade",
      description: "Vulnerabilidade aleatória",
      impact: 0,
      solution: "Solução da Vulnerabilidade",
      status:0,
      user_id: "INVALID_ATTRIBUTE"
    }
  }

  let(:valid_headers) {
    user.create_new_auth_token
  }

  describe "GET /index" do
    it "renders a successful response" do
      Vulnerability.create! valid_attributes
      get vulnerabilities_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      vulnerability = Vulnerability.create! valid_attributes
      get vulnerability_url(vulnerability), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Vulnerability" do
        expect {
          post vulnerabilities_url,
               params: { vulnerability: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Vulnerability, :count).by(1)
      end

      it "renders a JSON response with the new vulnerability" do
        post vulnerabilities_url,
             params: { vulnerability: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Vulnerability" do
        expect {
          post vulnerabilities_url,
               params: { vulnerability: invalid_attributes }, as: :json
        }.to change(Vulnerability, :count).by(0)
      end

      it "renders a JSON response with errors for the new vulnerability" do
        post vulnerabilities_url,
             params: { vulnerability: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: "Vulnerabilidade atualizada" }
      } 

      it "updates the requested vulnerability" do
        vulnerability = Vulnerability.create! valid_attributes
        patch vulnerability_url(vulnerability),
              params: { vulnerability: new_attributes }, headers: valid_headers, as: :json
        vulnerability.reload
        expect(vulnerability.name).to eq(new_attributes[:name])
      end

      it "renders a JSON response with the vulnerability" do
        vulnerability = Vulnerability.create! valid_attributes
        patch vulnerability_url(vulnerability),
              params: { vulnerability: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the vulnerability" do
        vulnerability = Vulnerability.create! valid_attributes
        patch vulnerability_url(vulnerability),
              params: { vulnerability: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested vulnerability" do
      vulnerability = Vulnerability.create! valid_attributes
      expect {
        delete vulnerability_url(vulnerability), headers: valid_headers, as: :json
      }.to change(Vulnerability, :count).by(-1)
    end
  end
end
