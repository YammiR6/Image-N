require 'spec_helper'
require 'challenge'

RSpec.describe Challenge do
    def app
        Challenge
    end

    describe "get base" do
        it "does something" do
            get "/challenge"
            expect(last_response.status).to eq(200)
            response = JSON.parse(last_response.body)
            expect(response).to eq({'hello' => 'World!'})
        end
    end
end
