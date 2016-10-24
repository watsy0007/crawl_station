require 'spec_helper'

RSpec.describe CrawlStation::Launcher do
  let!(:launcher) { CS::Launcher.new }
  it 'start should work' do
    producer = double()
    expect(producer).to receive_message_chain('async.start')
    expect(CS::Producer).to receive(:pool).and_return(producer)
    allow_any_instance_of(Celluloid::Actor).to receive(:sleep).and_return(true)
    expect(CS.logger).to receive(:debug)
    Celluloid::Notifications.publish 'exit_launcher', true
    launcher.start
  end
end
