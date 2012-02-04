require 'spec_helper'


class MockReporter
  attr_reader :locations, :complete_called

  def initialize
    @locations = Array.new
    @complete_called = Array.new
  end

  def add(location)
    @locations << location
  end
  
  def send_completed_result
    @complete_called << true
  end
end

describe LocationEngine do

  before(:each) do
    @location_parser = gimme() 
    give(@location_parser).id { "yelp" }
    @parser_reporter = MockReporter.new
    @location_engine = LocationEngine.new @location_parser, @parser_reporter
  end

  it 'should store all new locations retrieved' do
    competitor_location = gimme(Location)
    give!(competitor_location).exists?({:parser_id=>"yelp"}) {false}
    my_location = gimme(Location)
    give!(my_location).exists?({:parser_id=>"yelp"}) {false}
    give(@location_parser).get_all { [ competitor_location, my_location ] }
    @location_engine.store_new
    verify!(competitor_location).save! 
    verify!(my_location).save! 
  end

  it 'should not store old locations' do
    competitor_location = gimme(Location)
    give!(competitor_location).exists?({:parser_id=>"yelp"}) {false}
    my_location = gimme(Location)
    give!(my_location).exists?({:parser_id=>"yelp"}) {false}
    already_have_location = gimme(Location)
    give!(already_have_location).exists?({:parser_id=>"yelp"}) {true}
    give(@location_parser).get_all { [ competitor_location, my_location, already_have_location ] }

    @location_engine.store_new
    verify!(competitor_location).save! 
    verify!(my_location).save!
    verify!(already_have_location, 0).save!
  end
  
  it 'should send a report when parsing done' do
    location1 = gimme(Location)
    give!(location1).exists?({:parser_id=>"yelp"}) {false}
    location2 = gimme(Location)
    give!(location2).exists?({:parser_id=>"yelp"}) {true}

    give(@location_parser).get_all { [ location1, location2 ] }

    @location_engine.store_new

    @parser_reporter.should have(1).locations
    @parser_reporter.locations.should include(location1)

    @parser_reporter.should have(1).complete_called

  end
  
  #describe 'an error saving location'do

  #end

  
end
