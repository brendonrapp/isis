require 'spec/spec_helper'
require 'lib/isis/plugins/weather'

describe Isis::Plugin::Weather do
  let(:weather) { Isis::Plugin::Weather.new }

  context "#response" do
    it "should output the weather report" do
      output = weather.response.inspect
      expect(output).to match(/Aptos/)
      expect(output).to match(/Long Beach/)
      expect(output).to match(/Austin/)
      expect(output).to match(/Pismo Beach/)
    end
  end

  context "#timed_response" do
    it "should not output if it is not 8:11am Pacific" do
      Timecop.freeze(Time.utc(2013, 1, 1, 1, 1, 0))
      expect(weather.timed_response).to be_nil
    end

    it "should output if it is 8:11am Pacific on a weekday" do
      Timecop.freeze(Time.utc(2013, 1, 1, 16, 11, 0))
      expect(weather.timed_response).to_not be_nil
    end

    it "should only output once if called multiple times at 8:11am Pacific on a weekday" do
      Timecop.freeze(Time.utc(2013, 1, 1, 16, 11, 0))
      first_response = weather.timed_response
      second_response = weather.timed_response
      expect(first_response).not_to be_nil
      expect(second_response).to be_nil
    end
  end
end
