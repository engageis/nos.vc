

namespace :backers do
  desc 'This task will clear non confirmed backers which are older than a year'
  task :clean => :environment do
    puts "Cleaning backers older than #{1.year.ago} ..."
    Backer.not_confirmed.where('created_at < ?', 1.year.ago)
  end
end