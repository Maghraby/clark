require 'rails_helper'

RSpec.describe Validator do
  describe 'self.validate' do
    subject { validator.errors }
    let(:validator) { described_class.call(data) }

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

        it { expect(subject).to eq [] }
      end
    end

    context 'errors' do
      context 'when recommends row is not correct' do
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

        it { 
          expect(subject).not_to eq []
          expect(subject.first.message).to eq 'Row data in invalid for recommends actions at index 0'
        }
      end

      context 'when accepts row is not correct' do
        let(:data) do
          <<-str
            2018-06-12 09:41 A recommends B
            2018-06-14 09:41 accepts
            2018-06-16 09:41 B recommends C
            2018-06-17 09:41 C accepts
            2018-06-19 09:41 C recommends D
            2018-06-23 09:41 B recommends D
            2018-06-25 09:41 D accepts
          str
        end

        it { 
          expect(subject).not_to eq []
          expect(subject.first.message).to eq 'Row data in invalid for accepts actions at index 1'
        }
      end

      context 'when row have wrong actions' do
        let(:data) do
          <<-str
            2018-06-12 09:41 A recommends B
            2018-06-14 09:41 B blabla
            2018-06-16 09:41 B recommends C
            2018-06-17 09:41 C accepts
            2018-06-19 09:41 C recommends D
            2018-06-23 09:41 B recommends D
            2018-06-25 09:41 D accepts
          str
        end

        it { 
          expect(subject).not_to eq []
          expect(subject.first.message).to eq 'Action in invalid at index 1'
        }
      end
    end
  end
end