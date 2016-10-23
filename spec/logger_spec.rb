require 'spec_helper'

RSpec.describe CrawlStation::Logger do
  let(:logger) { CS.logger }
  let(:m_logger) { CS::Logger }
  it 'check proxy logger method' do
    %w(debug info warn error).each do |method|
      expect(logger.respond_to?(method)).to be true
    end
    expect(logger.respond_to?('error_method')).to be false
  end

  it 'must work with logger method' do
    CS::Logger.logger = mock_logger = double()
    expect(mock_logger).to receive(:error).with('error message')
    m_logger.error('error message')
  end

  it 'proxy station logger module method' do
    CS.logger = nil
    expect(m_logger.send(:error, '')).to be false
  end
end
