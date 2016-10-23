require 'spec_helper'

describe CrawlStation::Cache do
  let(:adapter) { CS::Cache.adapter }
  it 'valid schedule adapter should work' do
    expect(adapter.class.to_s).to include('Memory')
    CS.logger = logger = double
    expect(logger).to receive(:error)
    CS::Cache.adapter = :no_exist
  end
end
