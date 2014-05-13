require 'geomancer'

describe Geomancer do
  it "extracts basic latitude" do
    Geomancer.extract_lat_and_long("latitude: 41.9040 longitude: 12.4530").should_not be_nil
  end
  
  it "extracts abbreviated latitude" do
    Geomancer.extract_lat_and_long("lat: 41.9040 long: 12.4530").should_not be_nil
  end

  it "extracts comma separated stuff" do
    Geomancer.extract_lat_and_long("lat: 41.9040, long: 12.4530").should_not be_nil
  end

  it "doesn't extract only latitude" do
    Geomancer.extract_lat_and_long("lat: 41.9040").should be_nil
  end

  it "doesn't extract only longitude" do
    Geomancer.extract_lat_and_long("longitude: 41.9040").should be_nil
  end

  it "extracts actual numbers" do
    lat_and_long = Geomancer.extract_lat_and_long("lat: 41.9040, long: 12.4530")
    lat_and_long[:latitude].should be_a Float
    lat_and_long[:longitude].should be_a Float
  end

  it "extracts negative numbers" do
    lat_and_long = Geomancer.extract_lat_and_long("lat: 37.2350, long: -115.8111")
    lat_and_long[:longitude].should == -115.8111
  end
  

end
