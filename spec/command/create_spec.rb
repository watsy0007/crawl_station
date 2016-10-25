require 'spec_helper'

RSpec.describe CrawlStation::Command::Create do
  let(:obj) { CrawlStation::Command::Create.new }

  it 'create project should work' do
    expect(obj).to receive(:puts).at_least(4).times
    path = '/tmp'
    project_name = 'hello'
    expect(File).to receive(:expand_path).and_return(path)
    expect(FileUtils).to receive(:copy_entry).with("#{path}/crawl_station/templates/create", project_name)
    expect(Dir).to receive(:pwd).and_return(path)
    expect(IO).to receive(:popen).and_return([])
    expect(Dir).to receive(:chdir).with("#{path}/#{project_name}")
    obj.create([project_name])
  end
end
