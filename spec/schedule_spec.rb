require 'spec_helper'
describe CrawlStation::Schedule do
  let(:adapter) { CS::Schedule.adapter }
  it 'valid schedule adapter should work' do
    expect(adapter.class.to_s).to include('Memory')
    CS.logger = logger = double
    expect(logger).to receive(:error)
    CS::Schedule.adapter = :no_exist
  end
end
