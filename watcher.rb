#!/usr/local/bin/ruby

require "digest/md5"

trap("SIGINT") { exit }

if ARGV.empty?
  puts "Usage: #{$0} watch_folder"
  puts "       Example: #{$0} ."
  exit
end

watch_folder = ARGV[0]
watch_files  = "*.haml"

puts "Watching #{watch_folder} and subfolders for changes in #{watch_files} files..."

while true do
  new_hash = Digest::MD5.hexdigest(`find #{watch_folder} -name "#{watch_files}" -ls`);
  hash ||= new_hash
  
  if new_hash != hash
    hash = new_hash
    
    haml_files = File.join( watch_folder, "**", watch_files )
    Dir.glob(haml_files).each do |f|
      output_file = f.gsub(/\/haml\/([^\/]+)\.haml/, '/output/\1.html')
      cmd = "haml #{f} #{output_file}"
      puts "- #{cmd}"
      system(cmd)
    end
  end
  
  sleep 1
end