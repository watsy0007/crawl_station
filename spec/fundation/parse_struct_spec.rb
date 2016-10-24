require 'spec_helper'

RSpec.describe CrawlStation::ParseStruct do
  let(:obj) { CrawlStation::ParseStruct.new(parser: 'tech', namespace: 't66y', link: 'www.baidu.com') }
  let(:methods) { %w(namespace parser item link) }
  it 'valid dynamic method' do
    methods.each { |m_name| expect(obj.respond_to?(m_name)).to be true }
  end

  it 'dynamic call should be work' do
    methods.each { |m_name| obj.send("#{m_name}=", m_name) }
    methods.each { |m_name| expect(obj.send(m_name)).to eq m_name }
    methods.each { |m_name| obj.send('[]=', m_name, m_name) }
    methods.each { |m_name| expect(obj.send('[]', m_name)).to eq m_name }
  end

  it 'item class work' do
    stub_const('T66y::Item::Tech', 5)
    expect(obj.item_class).to eq 5
  end

  it 'parser class work' do
    stub_const('T66y::Parser::Tech', 5)
    expect(obj.parser_class).to eq 5
  end
end
