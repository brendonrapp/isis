# Include all files in plugins/ dir

Dir[File.dirname(__FILE__) + '/connections/*'].each { |file| require file }
