namespace :db do

  desc 'db:drop db:create db:migrate db:fixtures:load'
  task refresh: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:fixtures:load'].invoke
  end

end
