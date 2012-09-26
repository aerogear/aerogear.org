require 'net/sftp'

# aerogear@filemgmt.jboss.org:www_htdocs/aerogear
HOST = "filemgmt.jboss.org"
USERNAME = "aerogear"
PATH = "/www_htdocs/aerogear"
KEY_FILE = "/private/aerogear/aerogear-site"
BASE_FOLDER = "#{PATH}/staging.aerogear.org"
FOLDERS = Dir.glob("_site/**/").map {|f| f[0..-2]}
FILES = Dir.glob("_site/**/*") - FOLDERS

def normalize_folder(path)
  path.gsub(/^_site/, BASE_FOLDER)
end

Net::SFTP.start(HOST, USERNAME, :keys => [KEY_FILE]) do |sftp|
  sftp.mkdir(BASE_FOLDER) do |response|
    puts response
  end
  FOLDERS.each do |f|
    sftp.mkdir(normalize_folder(f)) do |response|
      puts "#{f} => #{response}"
    end.wait
  end
  FILES.each do |f|
    sftp.upload(f, normalize_folder(f)) do |event, uploader, *args|
      case event
      when :open then
        # args[0] : file metadata
        puts "starting upload: #{args[0].local} -> #{args[0].remote} (#{args[0].size} bytes}"
      when :put then
        # args[0] : file metadata
        # args[1] : byte offset in remote file
        # args[2] : data being written (as string)
        puts "writing #{args[2].length} bytes to #{args[0].remote} starting at #{args[1]}"
      when :close then
        # args[0] : file metadata
        puts "finished with #{args[0].remote}"
      when :mkdir then
        # args[0] : remote path name
        puts "creating directory #{args[0]}"
      when :finish then
        puts "all done!"
      end
    end
    sftp.loop
  end
end
