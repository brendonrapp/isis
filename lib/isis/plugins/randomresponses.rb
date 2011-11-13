

require 'isis/plugins/base'

class Isis::Plugin::RandomResponses < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    true
  end

  def response
    if (/\bpedo\b/i =~ msg || /\bpedobear\b/i =~ msg || /\bunderage\b/i =~ msg) then return "http://s3.amazonaws.com/kym-assets/entries/icons/original/000/000/005/pedobear.jpg"
    elsif /\bfriday\b/i =~ msg then return "http://nickshell1983.files.wordpress.com/2011/03/rebecca-black-friday.png"
    elsif /do it live/i =~ msg then return "http://rationalmale.files.wordpress.com/2011/09/doitlive.jpeg"
    elsif (/taxmaster/i =~ msg || /tax master/i =~ msg) then return "http://28.media.tumblr.com/tumblr_lixw8j6w1t1qzjw8go1_500.jpg"
    elsif (/danger zone/i =~ msg || /dangerzone/i =~ msg) then return "http://assets.diylol.com/hfs/1dd/bbc/c34/resized/archer-danger-zone-meme-generator-call-kenny-loggins-coz-you-re-in-the-danger-zone-d319a5.jpg?1306676751.jpg"
    else
      nil
    end
  end

end
