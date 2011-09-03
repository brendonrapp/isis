# Include all files in plugins/ dir

Dir[File.dirname(__FILE__) + '/plugins/*'].each { |file| require file }
