require 'spec_helper'

RSpec.describe CrawlStation::Command::Generate do
  let(:obj) { CrawlStation::Command::Generate.new }
  let(:utils) { CS::Utils }
  let(:module_name) { 't66y' }
  let(:parser_name) { 'tech' }
  let(:migrate_name) { parser_name }
  before { CS.logger = nil }
  context 'migration' do
    it 'args.size < 2' do
      expect(obj).to receive(:migration).and_raise(RuntimeError).and_return(true)
      obj.migration [1]
    end

    it 'g migration t66y create_tech' do
      f_path = "#{module_name}/#{migrate_name}"
      opts = { class_name: migrate_name.camelize }
      expect(obj).to receive(:dest_path).with(module_name, migrate_name).and_return(f_path)
      expect(utils).to receive(:template_filepath).and_return(f_path)
      expect(obj).to receive(:render).with(f_path, f_path, opts)
      expect(CS.logger).to receive(:debug).with(/done/)
      obj.migration [module_name, migrate_name]
    end
  end

  context 'new module' do
    it 'args error' do
      expect(obj).to receive(:new_module).and_raise(RuntimeError).and_return(true)
      obj.new_module []
    end

    it 'create new module' do
      expect(utils).to receive(:module_path).with(module_name).and_return(module_name)
      expect(File).to receive(:exist?).with(module_name).and_return(false)
      expect(CS.logger).to receive(:debug).with(/create new module/)
      expect(utils).to receive(:templates_path).and_return('')
      expect(FileUtils).to receive(:copy_entry).with('/generate/module', module_name)
      expect(CS.logger).to receive(:debug).with(/done/)
      obj.new_module [module_name]
    end
  end

  it 'new parser' do
    expect(CS.logger).to receive(:debug)
    expect(utils).to receive(:template_filepath).with('generate/parser.erb').and_return(module_name)
    expect(utils).to receive(:template_filepath).with('generate/item.erb').and_return(module_name)
    expect(obj).to receive(:parser_path).with(module_name, parser_name, 'parser').and_return('')
    expect(obj).to receive(:parser_path).with(module_name, parser_name, 'item').and_return('')
    opts = {
      module_class_name: module_name.camelize,
      class_name: parser_name.camelize
    }
    expect(obj).to receive(:render).with('', module_name, opts).twice
    obj.parser [module_name, parser_name]
  end

  it 'new parsers' do
    expect(obj).to receive(:parser).twice
    obj.parsers ['t66y', 'tech', 'image']
  end

  it 'dest path' do
    m_path = '/tmp'
    expect(utils).to receive(:module_path).with(module_name).and_return(m_path)
    expect(Dir).to receive(:exist?).with(m_path).and_return(true)
    expect(Dir).to receive(:exist?).with("#{m_path}/db/migrate").and_return(true)
    expect(obj.send(:dest_path, module_name, parser_name)).to match(/#{parser_name}/)
  end

  it 'parser path' do
    m_path = '/tmp'
    expect(utils).to receive(:module_path).with(module_name).and_return(m_path)
    expect(Dir).to receive(:exist?).with(m_path).and_return(true)
    expect(obj.send(:parser_path, module_name, parser_name)).to match(/#{parser_name}/)
  end

  it 'valid render method' do
    module_name = 'project'
    expect(utils).to receive(:render_context).and_return('')
    expect(utils).to receive(:render).with(module_name, '')
    obj.send(:render, module_name, '')
  end
end
