require 'spec_helper'

RSpec.describe CrawlStation::Cache do
  let(:adapter) { CS::Cache.adapter }
  # after(:each) { CS.logger = nil }
  it 'valid schedule adapter should work' do
    expect(adapter.class.to_s).to include('Memory')
    CS.logger = logger = double
    expect(logger).to receive(:error)
    CS::Cache.adapter = :no_exist
  end
end
