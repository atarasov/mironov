# coding: utf-8
require 'bundler/capistrano'
require 'bundler/setup'
#require 'thinking_sphinx/deploy/capistrano'
# В rails 3 по умолчанию включена функция assets pipelining,
# которая позволяет значительно уменьшить размер статических
# файлов css и js.
# Эта строка автоматически запускает процесс подготовки
# сжатых файлов статики при деплое.
# Если вы не используете assets pipelining в своем проекте,
# или у вас старая версия rails, закомментируйте эту строку.
load 'deploy/assets'

#require "delayed/recipes"

# Для удобства работы мы рекомендуем вам настроить авторизацию
# SSH по ключу. При работе capistrano будет использоваться
# ssh-agent, который предоставляет возможность пробрасывать
# авторизацию на другие хосты.
# Если вы не используете авторизацию SSH по ключам И ssh-agent,
# закомментируйте эту опцию.
ssh_options[:forward_agent] = true

# Имя вашего проекта в панели управления.
# Не меняйте это значение без необходимости, оно используется дальше.
set :application,     "mironov"
set :rails_env, "production"
# Сервер размещения проекта.
set :deploy_server,   "88.198.0.42"

# Не включать в поставку разработческие инструменты и пакеты тестирования.
set :bundle_without,  [:development, :test]

set :user,            "mironov"
set :login,           "mironov"
set :use_sudo,        false
set :deploy_to,       "/home/#{user}/www/project/#{login}"
set :unicorn_conf,    "/etc/unicorn/#{application}.#{login}.rb"
set :unicorn_pid,     "/home/#{user}/www/project/#{application}/shared/pids/#{application}.#{login}.pid"
set :bundle_dir,      File.join(fetch(:shared_path), 'gems')
set :delayed_job_server_role, :delayed_job
role :delayed_job,    deploy_server
role :web,            deploy_server
role :app,            deploy_server
role :db,             deploy_server, :primary => true
set :keep_releases, 3

# Следующие строки необходимы, т.к. ваш проект использует rvm.    1.9.3
#set :rvm_ruby_string, "1.9.3"
set :rvm_ruby_string, "ruby-2.0.0-p195@mironov"
set :rake,            "rvm use #{rvm_ruby_string} do bundle exec rake"
set :bundle_cmd,      "rvm use #{rvm_ruby_string} do bundle"

set :delayed_job_args, "-n 2"

# Настройка системы контроля версий и репозитария,
# по умолчанию - git, если используется иная система версий,
# нужно изменить значение scm.
set :scm,             :git

# Предполагается, что вы размещаете репозиторий Git в вашем
# домашнем каталоге в подкаталоге git/<имя проекта>.git.
# Подробнее о создании репозитория читайте в нашем блоге
# http://locum.ru/blog/hosting/git-on-locum
set :repository,      "git://204.232.175.90/atarasov/mironov.git"

## Если ваш репозиторий в GitHub, используйте такую конфигурацию
# set :repository,    "git@github.com:username/project.git"

## Чтобы не хранить database.yml в системе контроля версий, поместите
## dayabase.yml в shared-каталог проекта на сервере и раскомментируйте
## следующие строки.


#after "deploy:stop",    "delayed_job:stop"
#after "deploy:start",   "delayed_job:start"
#after "deploy:restart", "delayed_job:restart"

after "deploy:start", "dj:start"
after "deploy:stop", "dj:stop"

before "deploy:update_code", "dj:stop"
after "deploy:restart", "dj:restart"

# delayed_job
namespace :dj do
  desc "Start delayed_job daemon."
  task :start, :roles => :app do
    run "if [ -d #{current_path} ]; then cd #{current_path} && RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle exec script/delayed_job -n 2 start; fi"
  end
  desc "Stop delayed_job daemon."
  task :stop, :roles => :app do
    run "if [ -d #{current_path} ]; then cd #{current_path} && RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle exec script/delayed_job stop; fi"
  end

  desc "Restart delayed_job daemon."
  task :restart, :roles => :app do
    run "if [ -d #{current_path} ]; then cd #{current_path} && RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle exec script/delayed_job -n2 restart; fi"
  end

  desc "Show delayed_job daemon status."
  task :status, :roles => :app do
    run "if [ -d #{current_path} ]; then cd #{current_path} && RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle exec script/delayed_job status; fi"
  end

  desc "List the PIDs of all running delayed_job daemons."
  task :pids, :roles => :app do
    run "lsof | grep '#{deploy_to}/shared/log/delayed_job.log' | cut -c 1-21 | uniq | awk '/^ruby/ {if(NR > 0){system(\"echo \" $2)}}'"
  end

  desc "Kill all running delayed_job daemons."
  task :kill, :roles => :app do
    run "lsof | grep '#{deploy_to}/shared/log/delayed_job.log' | cut -c 1-21 | uniq | awk '/^ruby/ {if(NR > 0){system(\"kill -9 \" $2)}}'"
    run "if [-d #{current_path} ]; then cd #{current_path} && RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle exec script/delayed_job stop; fi" # removes orphaned pid file(s)
  end
end

before "deploy:assets:precompile", :copy_database_config
task :copy_database_config, roles => :app do
  db_config = "#{shared_path}/database.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
end


#task :before_update_code, :roles => [:app] do
#  thinking_sphinx.stop
#end
#
#task :symlink_sphinx_indexes, :roles => [:app] do
#  run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
#end

#git ss


## --- Ниже этого места ничего менять скорее всего не нужно ---

before 'deploy:finalize_update', 'set_current_release'
task :set_current_release, :roles => :app do
  set :current_release, latest_release
end


set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})"
set :parse_start_cmd, "(cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec rake bestru_parse RAILS_ENV=production)"


# - for unicorn - #
namespace :deploy do
  desc "Start application"
  task :start, :roles => :app do
    run unicorn_start_cmd
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
  end

  desc "Start parse"
  task :parse, :roles => :app do
    run parse_start_cmd
  end
end