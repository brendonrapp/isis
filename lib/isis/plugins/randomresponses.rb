require 'isis/plugins/base'

class Isis::Plugin::RandomResponses < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    @msg = msg
    true
  end

  def response
    REGEXPS.each do |regex, val|
      return val if regex =~ @msg
    end

    nil
  end

  REGEXPS = [
    [/(\bpedo\b|\bpedobear\b|\bunderage\b|\bpre[\s]?teen\b)/i, "http://s3.amazonaws.com/kym-assets/entries/icons/original/000/000/005/pedobear.jpg"],
    [/\bfriday\b/i, "http://nickshell1983.files.wordpress.com/2011/03/rebecca-black-friday.png"],
    [/do it live/i, "http://rationalmale.files.wordpress.com/2011/09/doitlive.jpeg"],
    [/\btax[\s]?master/i, "http://28.media.tumblr.com/tumblr_lixw8j6w1t1qzjw8go1_500.jpg"],
    [/danger[\s]?zone/i, "http://assets.diylol.com/hfs/1dd/bbc/c34/resized/archer-danger-zone-meme-generator-call-kenny-loggins-coz-you-re-in-the-danger-zone-d319a5.jpg?1306676751.jpg"],
    [/\bcreeper\b/i, ["CREEPER!", "http://gamesprays.com/files/resource_media/preview/minecraft-creeper-4381_preview.png"]],
    [/\bprincess\b/i, "http://4.bp.blogspot.com/_QL4iFaxQ-fo/TTexlxYOW1I/AAAAAAAAAJg/oMqb_Ir_q40/s400/sorry_mario.png"],
    [/(\b3\.50\b|tree[\s]?fitty|loch[\s]?ness)/i, "http://troll.me/images/3fiddy/he-came-in-and-was-like-gimme-tree-fitty.jpg"],
    [/\bbadger(s)?\b/i, "http://media.247sports.com/Uploads/Boards/771/21771/43157.jpg"],
    [/\bvisual[\s]?basic\b/i, "http://www.youtube.com/watch?v=hkDD03yeLnU"],
    [/\bthriller\b/i, "http://freddyo.com/wp-content/uploads/2010/03/jackson-lays-down-some-moves-in-the-zombie-dance-scene-from-his-1982-thriller-music-video-ct.jpg"]
  ]

end
