require 'spec_helper'
require 'transmitter/constant_resolver'

describe Transmitter::ConstantResolver do
  describe '#lookup_constant' do
    before { class Space; end }

    it 'resolves the constant' do
      described_class.new("Space").lookup_constant.should eq Space
    end
  end
end
