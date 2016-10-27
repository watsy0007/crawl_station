require 'spec_helper'

RSpec.describe CrawlStation::Utils do
  let(:utils) { CS::Utils }
  it 'module should under parser directory' do
    expect(utils.module_path('t66y')).to include('/module/t66y')
  end

  it 'get database path' do
    global_db_path = "#{CS.root}/config/database.yml"
    expect(utils.database_path).to eq global_db_path
    expect(utils.database_path('t66y')).to eq global_db_path
    allow(File).to receive(:exist?).and_return(true)
    expect(utils.database_path('t66y')).to include('/module/t66y')
  end

  context 'create database' do
    it 'success' do
      base = ActiveRecord::Base
      connection = double()
      expect(utils).to receive(:database_config).and_return(database: 'project')
      expect(base).to receive(:establish_connection).and_return(true)
      expect(base).to receive(:connection).and_return(connection)
      utils.create_database('')
    end
    it 'failed with error config' do
      base = ActiveRecord::Base
      connection = double()
      opts = { database: 'project' }
      expect(utils).to receive(:database_config).and_return(opts)
      expect(base).to receive(:establish_connection).with(opts).and_raise(RuntimeError)
      expect(base).to receive(:establish_connection).with(opts.merge(database: nil)).and_return(true)
      expect(base).to receive_message_chain('connection.create_database').and_return(true)
      utils.create_database('')
    end
  end

  it 'get database config' do
    yaml_text = <<-EOF
test:
  host: '0.0.0.0'
EOF
    allow(IO).to receive(:read).and_return(yaml_text)
    expect(utils.database_config[:host]).to eq '0.0.0.0'
  end

  it 'valid template file path' do
    expect(utils).to receive(:gem_path).and_return('/tmp')
    expect(utils.template_filepath('demo')).to eq '/tmp/templates/demo'
  end

  it 'gem path' do
    expect(File).to receive(:expand_path)
    utils.gem_path
  end

  it 'render context ' do
    expect(IO).to receive(:read).and_return('<%= project_name %>')
    result = utils.render_context('', project_name: 'project')
    expect(result).to eq 'project'
  end

  it 'render' do
    obj = double()
    expect(File).to receive(:open).and_yield(obj)
    expect(obj).to receive(:write)
    utils.render('', '')
  end
end
