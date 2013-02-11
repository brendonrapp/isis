require 'spec_helper'
require 'lib/isis/plugins/hackernews'

describe Isis::Plugin::HackerNews do
  let(:hn) { Isis::Plugin::HackerNews.new }

  context "#timed_response" do
    it "outputs the top stories at 8:12 am" do
      Timecop.freeze(Time.utc(2013, 1, 3, 16, 12, 0))
      output = hn.timed_response
      expect(output).to match(/Top stories on HackerNews/)
      expect(output).to match(/a href=/)
      expect(output).to match(/points by/)
      expect(output).to match(/http/)
    end
  end

  context "#response" do
    it "outputs the top stories" do
      output = hn.response
      expect(output).to match(/Top stories on HackerNews/)
      expect(output).to match(/a href=/)
      expect(output).to match(/points by/)
      expect(output).to match(/http/)
    end
  end
end
