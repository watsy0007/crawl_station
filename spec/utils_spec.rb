require 'spec_helper'

describe CrawlStation::Utils do
  let(:utils) { CS::Utils }
  it 'module should under parser directory' do
    expect(utils.module_path('t66y')).to include('/parser/t66y')
  end

  it 'get database path' do
    global_db_path = "#{CS.root}/config/database.yml"
    expect(utils.database_path).to eq global_db_path
    expect(utils.database_path('t66y')).to eq global_db_path
    allow(File).to receive(:exist?).and_return(true)
    expect(utils.database_path('t66y')).to include('/parser/t66y')
  end

  it 'get database config' do
    yaml_text = <<-EOF
development:
  host: '0.0.0.0'
EOF
    allow(IO).to receive(:read).and_return(yaml_text)
    expect(utils.database_config[:host]).to eq '0.0.0.0'
  end
end
