require 'rails_helper'

RSpec.describe 'RecommendationsController', type: :request do
  include_context 'API Context'
  describe "#POST" do
    it 'returns Empty when no data sent' do
      post "/"
      expect(payload).to eq []
    end

    it 'returns result for valid data' do
      str = <<-str
        2018-06-12 09:41 A recommends B
        2018-06-14 09:41 B accepts
        2018-06-16 09:41 B recommends C
        2018-06-17 09:41 C accepts
        2018-06-19 09:41 C recommends D
        2018-06-23 09:41 B recommends D
        2018-06-25 09:41 D accepts
      str

      post '/', params: str, headers: {}

      expect(response.status).to eq 200
      expect(payload).to eq [{"A"=>1.75}, {"B"=>1.5}, {"C"=>1.0}]
    end

    it 'returns errror when row is not as expected' do
      str = <<-str
        2018-06-12 09:41 A recommends
        2018-06-14 09:41 B accepts
        2018-06-16 09:41 B recommends C
        2018-06-17 09:41 C accepts
        2018-06-19 09:41 C recommends D
        2018-06-23 09:41 B recommends D
        2018-06-25 09:41 D accepts
      str

      post '/', params: str, headers: {}

      expect(response.status).to eq 422
      expect(payload['errors']).to eq ["Row data in invalid for recommends actions at index 0"]
    end
  end
end