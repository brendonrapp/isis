require 'spec_helper'
require 'lib/isis/plugins/good_morning'

describe Isis::Plugin::GoodMorning do
  let(:gm) { Isis::Plugin::GoodMorning.new }

  before(:each) do
    gm.reset
  end

  context "#joined" do
    it "says good morning if user joins in the morning" do
      Timecop.freeze(Time.utc(2013, 1, 1, 16, 10, 0)) # 8:10am Pacific
      expect(gm.joined("Mokey")).to eq("Good morning, Mokey!")
    end

    it "says good morning and good weekend if user joins on a Monday morning" do
      Timecop.freeze(Time.utc(2012, 12, 31, 16, 10, 0))
      expect(gm.joined("Reginald VelJohnson")).to eq("Good morning, Reginald VelJohnson! I hope you had a good weekend.")
    end

    it "says good morning only once if user joins multiple times" do
      Timecop.freeze(Time.utc(2013, 1, 3, 16, 10, 0))
      expect(gm.joined("Alan Rickman")).to eq("Good morning, Alan Rickman!")
      expect(gm.joined("Alan Rickman")).to be_nil
      Timecop.freeze(Time.utc(2013, 1, 3, 16, 15, 0))
      expect(gm.joined("Alan Rickman")).to be_nil
    end

    it "says good morning once per day" do
      Timecop.freeze(Time.utc(2013, 1, 3, 16, 10, 0))
      expect(gm.joined("Jewel Staite")).to eq("Good morning, Jewel Staite!")
      Timecop.freeze(Time.utc(2013, 1, 3, 16, 15, 0))
      expect(gm.joined("Jewel Staite")).to be_nil
      Timecop.freeze(Time.utc(2013, 1, 4, 16, 12, 0))
      expect(gm.joined("Jewel Staite")).to eq("Good morning, Jewel Staite!")
      Timecop.freeze(Time.utc(2013, 1, 4, 16, 25, 0))
      expect(gm.joined("Jewel Staite")).to be_nil
    end
  end
end
