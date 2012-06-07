require File.expand_path('../../../test_helper', __FILE__)

module Etsy
  class ResponseTest < Test::Unit::TestCase

    context "An instance of the Response class" do

      should "be able to decode the JSON data to a hash" do
        data = '{ "foo":"bar" }'

        r = Response.new(stub(:body => data))
        r.to_hash.should == {'foo' => 'bar'}
      end

      should "only decode the JSON data once" do
        JSON.expects(:parse).once.returns({})

        r = Response.new(stub(:body => '{ "foo":"bar" }'))
        2.times { r.to_hash }
      end

      should "have a record count when the response is not paginated" do
        raw_response = mock
        raw_response.stubs(:body => '{ "count": 1 }')
        r = Response.new(raw_response)

        r.count.should == 1
      end

      should "have a record count when the response is paginated" do
        raw_response = mock
        raw_response.stubs(:body => '{ "count": 100, "results": [{},{}], "pagination": {} }')
        r = Response.new(raw_response)

        r.count.should == 2
      end

      should "return an array if there are multiple results entries" do
        r = Response.new('')
        r.expects(:to_hash).with().returns('results' => %w(one two))

        r.result.should == %w(one two)
      end

    end


  end
end
