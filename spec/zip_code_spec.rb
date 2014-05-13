require 'geomancer'

describe Geomancer do
  context 'zips' do
    ["15217", "15217-3343"].each do |zip|
      it "detects #{zip}" do
        Geomancer.zip_code_only?(zip).should be_true
      end
    end
  end

  context 'non-zips' do
    ["123456", "123456-22"].each do |nonzip|
      it "doesn't detect #{nonzip}" do
        Geomancer.zip_code_only?(nonzip).should be_false
      end
    end
  end
end
