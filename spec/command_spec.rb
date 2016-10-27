require 'spec_helper'

RSpec.describe CrawlStation::Command do
  let(:logger) { double() }
  before { CS.logger = logger }
  after { CS.logger = nil }
  it 'invoke should work' do
    klass = double()
    obj = double()
    stub_const('CrawlStation::Command::Create', klass)
    expect(klass).to receive(:new).and_return(obj)
    expect(obj).to receive(:create)
    CrawlStation::Command.invoke('create', 't66y')
  end

  it 'invoke not exist command' do
    expect(CrawlStation::Command).to receive(:invoke).and_raise(NameError).and_return(true)
    CrawlStation::Command.invoke('not_exist', 't66y')
  end

  it 'valid method name' do
    args = ['m', 't66y']
    expect(CS::Command.method_name('create', args)).to eq 'create'
    expect(CS::Command.method_name('g', args)).to eq 'm'
    expect(args).to eq ['t66y']
  end
end
