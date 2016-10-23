require 'spec_helper'

describe CrawlStation::ApplicationRecord do
  let(:kodule) { 'T66y' }
  let(:model) { 'Model' }
  let(:module_model) { "#{kodule}::#{model}" }
  before(:each) do
    Object.const_set(kodule, Module.new)
    kodule.constantize.const_set(model, Class.new(CS::ApplicationRecord))
  end
  after(:each) do
    kodule.constantize.send(:remove_const, model)
    Object.send(:remove_const, kodule)
  end
  it 'get table name prefix' do
    expect(module_model.constantize.table_name_prefix).to eq 't66y_'
  end

  it 'valid database' do
    hash = { host: '0.0.0.0' }
    allow(CS::Utils).to receive(:database_config).with(kodule.downcase).and_return(hash)
    expect(module_model.constantize.database_config[:host]).to eq '0.0.0.0'
  end
end
