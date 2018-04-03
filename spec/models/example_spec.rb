require 'spec_helper'
require 'models/example'

RSpec.describe 'example' do

	it 'should have a string representation' do
        expect(Example.new("Something").to_s).to eq('Something')
    end

end
