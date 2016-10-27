namespace :db do
  def exec_task(task, args)
    Rake::Task[task].reenable
    Rake::Task[task].invoke(args)
  end

  def db_operation(operator)
    task_name = "db:#{operator}"
    exec_task(task_name, 'crawl_station')
    Dir["#{CrawlStation.root}/module/*"].each do |dir|
      module_name = dir.split('/').last
      exec_task(task_name, module_name)
    end
  end

  desc 'db:create[module_name] if module_name is nil, create all module databases'
  task :create, [:module_name] do |_t, args|
    m_name = args[:module_name]
    if m_name.nil?
      CS.logger.debug 'db create all database'
      db_operation(:create)
      CS.logger.debug 'db create all done'
    else
      m_name = nil if m_name == 'crawl_station'
      CS.logger.debug("create database #{m_name}")
      CrawlStation::Utils.create_database(m_name)
      CS.logger.debug("create database #{m_name} done")
    end
  end

  desc 'db:migrate[module_name] if module_name is nil, migrate all module migrations'
  task :migrate, [:module_name] => :environment do |_t, args|
    puts args
    version = ENV['VERSION']
    module_name = args[:module_name]
    if module_name.nil?
      CS.logger.debug 'db migrate all migration'
      db_operation(:migrate)
      CS.logger.debug 'db migrate all done'
    else
      path = "#{CrawlStation::Utils.module_path(module_name)}/db/migrate"
      path = "#{CrawlStation::Utils.gem_path}/db/migrate" if module_name == 'crawl_station'
      puts path
      ActiveRecord::Migrator.migrate(path, version ? version.to_i : nil)
    end
  end

  task :environment, [:module_name] do |_t, args|
    puts "env #{args}"
    config = CrawlStation::Utils.database_config args[:module_name]
    ActiveRecord::Base.logger = CrawlStation.logger
    ActiveRecord::Base.establish_connection config
  end
end
