require 'rails_helper'

RSpec.describe Node do
  describe '#self.call' do
    it 'returns Node object' do
      node = described_class.call('A')
      expect(node.value).to eq 'A'
      expect(node.points).to eq 0
      expect(node.parent).to eq nil
    end

    it 'return parent correctly' do
      parent = described_class.call('A')
      child = described_class.call('B', parent)

      expect(child.value).to eq 'B'
      expect(child.points).to eq 0
      expect(child.parent).to eq parent
    end
  end
end