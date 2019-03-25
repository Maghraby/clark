require 'rails_helper'

RSpec.describe Parsing do
  describe '.parse' do
    subject { parser }
    let(:parser) { described_class.call(data) }

    context 'Retun array ob objects' do
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

      it { expect(subject.size).to eq(7) }
      it { expect(subject.first).to eq OpenStruct.new(from: 'A', to: 'B', accepts?: false, recommends?: true) }
    end
  end
end