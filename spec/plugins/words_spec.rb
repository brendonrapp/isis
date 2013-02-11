require 'spec_helper'
require 'lib/isis/plugins/words'

class Isis::Plugin::Words
  attr_accessor :db
end

describe Isis::Plugin::Words do
  let(:w) { Isis::Plugin::Words.new }
  
  before(:each) do
    w.reset
  end

  it "should count words" do
    Timecop.freeze(Time.utc(2013,1,1,16,15,0))
    w.respond_to_msg?("three blind mice", "nobody")
    w.respond_to_msg?("three blind mice", "nobody")
    w.respond_to_msg?("see how they run", "nobody")
    w.respond_to_msg?("three", "nobody")
    expect(w.db["three"].to_i).to eq(3)
    expect(w.db["blind"].to_i).to eq(2)
  end

  it "should not count words on weekends, only weekdays" do
    Timecop.freeze(Time.utc(2013,1,5,18,0,0))
    w.respond_to_msg?("count me not", "nobody")
    expect(w.db["count"].to_i).to eq(0)
    Timecop.freeze(Time.utc(2013,1,7,18,0,0))
    w.respond_to_msg?("count me", "nobody")
    expect(w.db["count"].to_i).to eq(1)
  end

  it "should output the word of the day at 8:10 am Pacific" do
    Timecop.freeze(Time.utc(2013,1,7,19,10,0))
    w.respond_to_msg?("abba zabba zabba dabba doo", "nobody")
    w.respond_to_msg?("abba zabba zabba dabba doo", "nobody")
    w.respond_to_msg?("abba zabba zabba dabba doo", "nobody")
    Timecop.freeze(Time.utc(2013,1,8,16,10,0))
    output = w.timer_response.to_s
    expect(output).to match(/Zabba/)
  end
end
