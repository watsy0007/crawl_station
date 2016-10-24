require 'spec_helper'

RSpec.describe CrawlStation::Producer do
  let(:schedule) { double() }
  let(:cache) { double() }
  let(:producer) { CS::Producer.new(schedule, cache) }
  before { allow_any_instance_of(Celluloid::Actor).to receive(:sleep).and_return(true) }
  it 'start should be work' do
    allow_any_instance_of(CS::Producer).to receive(:loop_parser).and_return(false)
    producer.start
  end

  context 'loop parser' do

    it 'parser with schedule empty' do
      expect(schedule).to receive(:empty?).and_return(true)
      producer.loop_parser
    end

    it 'parser with parsed item should work' do
      expect(schedule).to receive(:empty?).and_return(false)
      expect(schedule).to receive(:pop).and_return(nil)
      producer.loop_parser
    end

    it 'parser item return nil should work' do
      expect(schedule).to receive(:empty?).and_return(false)
      expect(schedule).to receive(:pop).and_return(CS::ParseStruct.new(link: 'www.baidu.com'))
      allow_any_instance_of(CS::Producer).to receive(:parsed?).and_return(false)
      allow_any_instance_of(CS::Producer).to receive(:parse_item).and_return(nil)
      expect(CS.logger).to receive(:debug)
      producer.loop_parser
    end

    it 'parser links return nil should work' do
      expect(schedule).to receive(:empty?).and_return(false)
      expect(schedule).to receive(:pop).and_return(CS::ParseStruct.new(link: 'www.baidu.com', namespace: 't66y'))
      allow_any_instance_of(CS::Producer).to receive(:parsed?).and_return(false)
      allow_any_instance_of(CS::Producer).to receive(:parse_item).and_return(pages: [])
      allow_any_instance_of(CS::Producer).to receive(:parse_links).and_return({})
      expect(CS.logger).to receive(:debug)
      producer.loop_parser
    end

    it 'parser data save' do
      expect(schedule).to receive(:empty?).and_return(false)
      item = double()
      expect(schedule).to receive(:pop).and_return(item)
      expect(item).to receive(:link).twice
      expect(item).to receive(:namespace)
      expect(item).to receive_message_chain('item_class.new.save')
      allow_any_instance_of(CS::Producer).to receive(:parsed?).and_return(false)
      allow_any_instance_of(CS::Producer).to receive(:parse_item).and_return(pages: [])
      allow_any_instance_of(CS::Producer).to receive(:parse_links).and_return(data: [])
      expect(CS.logger).to receive(:debug)
      producer.loop_parser
    end
  end

  it 'parse item correct' do
    item = double()
    expect(cache).to receive(:[]=).twice
    expect(item).to receive(:[]).and_return('www.baidu.com').twice
    expect(item).to receive(:link).and_return('www.baidu.com')
    expect(item).to receive_message_chain('parse_class.new.crawl') { nil }
    expect(schedule).to receive(:done)
    producer.parse_item(item)
  end

  it 'parse not exist item' do
    item = double()
    expect(cache).to receive(:[]=)
    expect(item).to receive(:[]).and_return('www.baidu.com')
    expect(item).to receive(:link).and_return('www.baidu.com')
    expect(schedule).to receive(:failed)
    producer.parse_item(item)
  end

  it 'parse links should work' do
    data = {
      'pages' => [{ 'link' => 'www.baidu.com', 'parser' =>'tech' }],
      'details' => [{ 'link' => 'wwww.baidu.com', 'parser' => 'tech' }]
    }
    expect(cache).to receive(:include?).and_return(false).twice
    expect(schedule).to receive(:push).twice
    value = producer.parse_links(data, 't66y')
    expect(value.empty?).to eq true
  end

  it 'cache should work' do
    data = { link: 'www.baidu.com' }
    expect(cache).to receive(:[]=).twice
    value = producer.cache(data) { data }
    expect(value[:link]).to eq data[:link]
  end

  it 'parsed? should work' do
    data = { link: 'www.baidu.com' }
    expect(cache).to receive(:include?).and_return(true)
    expect(producer.parsed?(data)).to be true
    expect(producer.parsed?(nil)).to be true
  end
end
