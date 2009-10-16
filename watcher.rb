#!/usr/local/bin/ruby

require "digest/md5"

trap("SIGINT") { exit }

if ARGV.empty?
  puts "Usage: #{$0} watch_folder"
  puts "       Example: #{$0} ."
  exit
end

watch_folder = ARGV[0]
mtimes = {}

puts "Watching #{watch_folder} and subfolders for changes in SASS & HAML files..."

while true do
  new_hash = Digest::MD5.hexdigest(`find #{watch_folder} \\( -name "*.haml" -or -name "*.sass" \\) -ls`);
  hash ||= new_hash
  
  if new_hash != hash
    hash = new_hash
    
    files = Dir.glob( File.join( watch_folder, "**", "*.haml" ) )
    files += Dir.glob( File.join( watch_folder, "**", "*.sass" ) )

    files.each do |f|
      f_mtime = File.mtime(f).to_i
      next if mtimes[f] == f_mtime
      
      output_file = ""
      
      ex = f.match(/(sass|haml)$/)[1]
      case ex
      when "haml"
        output_file = f.gsub(/\/haml\/([^\/]+)\.haml/, '/output/\1.html')
      when "sass"
        output_file = f.gsub(/\/sass\/([^\/]+)\.sass/, '/css/\1.css')
      end

      cmd = "#{ex} #{f} #{output_file}"
      puts "- #{cmd}"
      system(cmd)
      
      mtimes[f] = f_mtime
    end
  end
  
  sleep 1
end