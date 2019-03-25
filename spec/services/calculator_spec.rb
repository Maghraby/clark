require 'rails_helper'

RSpec.describe Calculator do
  describe 'self.calculate' do
    subject { calculator }
    let(:calculator) { described_class.call(data) }

    context 'success' do
      context 'valid string given' do
        let(:data) do
          <<-str
            2018-06-12 09:41 A recommends B
            2018-06-14 09:41 B accepts
            2018-06-16 09:41 B recommends C
            2018-06-17 09:41 C accepts
            2018-06-19 09:41 C recommends D
            2018-06-23 09:41 B recommends D
            2018-06-25 09:41 D accepts
          str
        end

        it { expect(subject.response).to eq [{"A"=>1.75}, {"B"=>1.5}, {"C"=>1.0}] }
      end
    end

    context 'error' do
      context 'invalid string given' do
        let(:data) do
          <<-str
            2018-06-12 09:41 A recommends
            2018-06-14 09:41 B accepts
            2018-06-16 09:41 B recommends C
            2018-06-17 09:41 C accepts
            2018-06-19 09:41 C recommends D
            2018-06-23 09:41 B recommends D
            2018-06-25 09:41 D accepts
          str
        end

        it { expect(subject.success?).to eq false }
        it { expect(subject.errors).not_to eq [] }
      end
    end
  end
end