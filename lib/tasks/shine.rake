desc 'Delete all Client photos and restore default'
task :photo_clobber => :environment do
  safe_mode = ENV['execute'] == 'true' ? false : true
  puts safe_mode ? 'Running In Safe Mode' : 'Executing Task'
  count = 0
  Dir.entries('./public/system/photos').each do |d|
    next if ['.', '..', File.basename(DEFAULT_PHOTO)].include?(d)
    path = File.join('./public/system/photos', d)
    puts "Deleting: #{path}"
    FileUtils.rm_rf(path) unless safe_mode
    count += 1
  end
  unless safe_mode
    Client.find_in_batches batch_size: 100 do |client_batch|
      client_batch.each do |client|
        client.update_attribute(:photo_url, DEFAULT_PHOTO)
      end
    end
  end
  puts "#{count} File#{count == 1 ? nil : 's'} Deleted"
end

desc 'Delete all photos where Client does not exist and restore default'
task :photo_cleanup => :environment do
  # Dir.entries('./public/system/photos').each do |d|
  #   next if ['.', '..', File.basename(DEFAULT_PHOTO)].include?(d)
  #   puts File.join('./public/system/photos', d)
  # end
end
