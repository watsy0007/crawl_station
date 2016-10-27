require 'spec_helper'

RSpec.describe CrawlStation::Command::Create do
  let(:obj) { CrawlStation::Command::Create.new }
  let(:logger) { CS.logger }
  let(:utils) { CS::Utils }
  before { CS.logger = nil }
  it 'create project should work' do
    dir_root = 'project'
    expect(obj).to receive(:logs).at_least(4).times
    expect(utils).to receive(:templates_path).and_return(dir_root)
    expect(FileUtils).to receive(:copy_entry).with("#{dir_root}/create/dirs", dir_root)
    expect(obj).to receive(:render_database)
    expect(Dir).to receive(:pwd).and_return('')
    expect(Dir).to receive(:chdir).with("/#{dir_root}")
    expect(IO).to receive(:popen).with('bundle install').and_return([])
    obj.create [dir_root]
  end

  it 'render database' do
    tmp_path = 'tmp'
    dir_root = 'project'
    db_path = "#{tmp_path}/create/database.erb.yml"
    dest_path = "#{tmp_path}/#{dir_root}/config/database.yml"
    expect(utils).to receive(:templates_path).and_return(tmp_path)
    expect(utils).to receive(:render_context).with(db_path, project_name: dir_root).and_return(dir_root)
    expect(CS).to receive(:root).and_return(tmp_path)
    expect(utils).to receive(:render).with(dest_path, dir_root)
    obj.send(:render_database, dir_root)
  end

  it 'logs' do
    expect(logger).to receive(:debug)
    obj.send :logs, ''
  end
end
