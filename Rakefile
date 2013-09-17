require 'bundler'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << "lib" << "test"
  t.test_files = FileList['test/plugin/*.rb']
  t.verbose = true
end
