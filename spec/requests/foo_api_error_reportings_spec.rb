require 'rails_helper'

RSpec.describe "FooApiErrorReportings", type: :request do
  context "create a new Foo" do
    let(:foo_state) { FactoryGirl.attributes_for(:foo) }

    it "invalid Foo reports API error" do
      jpost foos_path, :foo=>{:id=>1}
      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to eq("application/json") 

      payload=parsed_body
      expect(payload).to have_key("errors")
      expect(payload["errors"]).to have_key("full_messages")
      expect(payload["errors"]["full_messages"][0]).to include("cannot")
    end
  end
end