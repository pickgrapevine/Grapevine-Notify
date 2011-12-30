require 'test_helper'
require_relative "../../../lib/http_parser"

class HttpParserTest < ActiveSupport::TestCase
  include HttpParser
  
  def setup
    @sent_headers = Hash.new
  end
  
  def open(url, hdrs)
    @sent_headers = hdrs
    Array.new
  end
  
  test "should use chrome header when random gives 0" do
    def rand(range)
      return 0
    end
    read_html("http://foo")
    assert_equal @sent_headers["User-Agent"], "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.63 Safari/535.7"
  end
  
  test "should use firefox header when random gives 1" do
    def rand(range)
      return 1
    end
    read_html("http://foo")
    assert_equal @sent_headers["User-Agent"], "Mozilla/5.0 (Windows NT 5.1; rv:9.0.1) Gecko/20100101 Firefox/9.0.1"
  end
  
  test "should use ie8 header when random gives 2" do
    def rand(range)
      return 2
    end
    read_html("http://foo")
    assert_equal @sent_headers["User-Agent"],"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; IPH 1.1.21.4019; .NET4.0C; .NET4.0E)"
  end
  
  test "should use ie7 header when random gives 3" do
    def rand(range)
      return 3
    end
    read_html("http://foo")
    assert_equal @sent_headers["User-Agent"], "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; IPH 1.1.21.4019; .NET4.0C; .NET4.0E)"
  end
  
  
end