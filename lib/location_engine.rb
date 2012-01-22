class LocationEngine

  def initialize(parser, reporter)
    @parser = parser
    @parser_reporter = reporter
  end

  def store_new
    locations = @parser.get_all
    locations.each do |location|
      unless location.exists?({:parser_id=>@parser.id})
        location.save!
        @parser_reporter.add(location)
      end
    end
    @parser_reporter.send_completed_result
  end

end
