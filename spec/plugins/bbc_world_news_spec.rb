require 'spec_helper'
require 'lib/isis/plugins/bbcworldnews'

describe Isis::Plugin::BBCWorldNews do
  let(:bbc) { Isis::Plugin::BBCWorldNews.new }

  context "#timed_response" do
    it "outputs the top stories at 8:13 am" do
      Timecop.freeze(Time.utc(2013, 1, 3, 16, 13, 0))
      output = bbc.timed_response
      expect(output).to match(/Top stories from BBC World News/)
      expect(output).to match(/a href=\"http:\/\/www.bbc.co.uk\/news\//)
      expect(output).to match(/http/)
    end

    it "does not output the top stories at times other than 8:13 am" do
      Timecop.freeze(Time.utc(2013, 1, 3, 16, 15, 0))
      output = bbc.timed_response
      expect(output).to be_nil
    end
  end
  
  context "#response" do
    it "outputs the top stories" do
      output = bbc.response
      expect(output).to match(/Top stories from BBC World News/)
      expect(output).to match(/a href=\"http:\/\/www.bbc.co.uk\/news\//)
      expect(output).to match(/http/)
    end
  end
end
