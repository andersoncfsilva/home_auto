require 'spec_helper'

RSpec.describe HomeAuto do
  let(:pin) { double }
  before { allow(PiPiper::Pin).to receive(:new) { pin } }

  subject { HomeAuto.new(YAML.load_file('./config/config.yml')['test']['home_auto']) }

  it { expect(subject).not_to be(nil) }

  describe '.dimmers' do
    it { expect(subject.dimmers).to be_a(Array) }
  end

  describe '.find_dimmer' do
    it { expect(subject.find_dimmer('test_room_1')).to be_a(Hash) }
  end

  describe '.switches' do
    it { expect(subject.switches).to be_a(Array) }
  end

  describe '.find_switch' do
    it { expect(subject.find_switch('test_room_1')).to be_a(Hash) }
  end

  describe '.set_switch' do
    context 'on' do
     before { expect(pin).to receive(:on) }
     it { subject.set_switch('test_room_1', 'true') }
    end

    context 'off' do
     before { expect(pin).to receive(:off) }
     it { subject.set_switch('test_room_1', 'false') }
    end

    context 'with invalid status' do
      it { expect{subject.set_switch('test_room_1', 'nonsense')}.to raise_error("invalid switch status: nonsense") }
    end
  end
end
