namespace :db do
  def db_operation(operator)
    Rake::Task["db:#{operator}"].invoke('crawl_station')
    Dir["#{CrawlStation.root}/module/*"].each do |dir|
      module_name = dirr.split('/').last
      Rake::Task["db:#{operator}"].invoke(module_name)
    end
  end

  desc 'db:create[module_name] if module_name is nil, create all module databases'
  task :create, [:module_name] => :environment do |_t, args|
    m_name = args[:module_name]
    return db_operation(:create) if m_name.nil?
    m_name = nil if m_name == 'crawl_station'
    CrawlStation::Utils.create_database(m_name)
  end

  desc 'db:migrate[module_name] if module_name is nil, migrate all module migrations'
  task :migrate, [:module_name] => :environment do |_t, args|
    version = ENV['VERSION']
    module_name = args[:module_name]
    return db_operation(:migrate) if module_name.nil?
    path = "#{CrawlStation::Utils.module_path(module_name)}/db/migrate"
    path = "#{CrawlStation::Utils.gems_path}/db/migrate" if module_name == 'crawl_station'
    ActiveRecord::Migrator.migrate(path, version ? version.to_i : nil)
  end

  task :environment, [:module_name] do |_t, args|
    config = CrawlStation::Utils.database_config args[:module_name]
    ActiveRecord::Base.logger = CrawlStation.logger
    ActiveRecord::Base.establish_connection config
  end
end
