#!/usr/local/bin/ruby

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
  files = Dir.glob( File.join( watch_folder, "**", "*.haml" ) )
  files += Dir.glob( File.join( watch_folder, "**", "*.sass" ) )

  new_hash = files.collect {|f| [ f, File.stat(f).mtime.to_i ] }
  hash ||= new_hash
  diff_hash = new_hash - hash
  
  unless diff_hash.empty?
    hash = new_hash
    
    diff_hash.each do |df|
      f = df.first
      
      output_file = ""
      options = ""
      
      ex = f.match(/(sass|haml)$/)[1]
      case ex
      when "haml"
        output_file = f.gsub(/\/haml\/([^\/]+)\.haml/, '/output/\1.html')
      when "sass"
        options = "--style compact"
        output_file = f.gsub(/\/sass\/([^\/]+)\.sass/, '/css/\1.css')
      end

      cmd = "#{ex} #{options} #{f} #{output_file}"
      puts "- #{cmd}"
      system(cmd)
    end
  end
  
  sleep 1
end