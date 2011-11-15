require 'isis/plugins/base'

class Isis::Plugin::Futurama < Isis::Plugin::Base

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
    [/(\bacting\b|\bcalculon\b)/i, "calculon-image"],
    [/\bsnoo snoo\b/i, "http://media.tumblr.com/tumblr_l27nvfY0M21qachms.jpg"],
    [/\broberto\b/i, "http://i8.photobucket.com/albums/a8/Bear_Micky_2/m_pic/_eskizi/futurama_roberto-wanted_250x390.jpg"],
    [/(\bhedonism\b|\bhedonism[\s]?bot\b|\bapologize\b)/i, "http://25.media.tumblr.com/tumblr_kpzxp5IIc81qzdsi5o1_400.jpg"],
    [/\bhooray/i, "http://scottgammans.com/blog/wp-content/uploads/2009/08/futurama.jpg"],
    [/\buseful\b/i, "http://i.qkme.me/4mot.jpg"],
    [/\bvote\b/i, "http://thesquirrelsnest.files.wordpress.com/2008/07/vote-robot-nixon.gif"],
    [/\brobot nixon\b/i, "http://2.bp.blogspot.com/_fjYT2JqJOYg/SQ-RbU6Hr6I/AAAAAAAAAAg/u-Jo_ubW7aI/s320/Robot+Nixon.jpg"],
    [/\bconundrum\b/i, "http://i374.photobucket.com/albums/oo188/bSb1337/Zapp-Brannigan-Kif-We-have-a-Conundrum.jpg"],
    [/\bvelour\b/i, "http://www.hwdyk.com/q/images/futurama_1_4_08.jpg"],
    [/omicron/i, "http://images.wikia.com/en.futurama/images/3/37/Omicron_Persei_8.JPG"],
    [/\blrrr\b/i, "http://images.wikia.com/en.futurama/images/9/96/Lrrr.jpg"],
    [/bender is great/i, "http://static.fjcdn.com/pictures/Bender+Bender+is+great_41e639_1180736.jpg"],
    [/sexlexia/i, "http://static.fjcdn.com/pictures/Zapp+Brannigan+2+funnyjunk+com+funny+pictures+1342542+Zapp+Brannigan_9f5cff_1342667.jpg"],
    [/wiener/i, "http://images.fanpop.com/images/image_uploads/I-C--Weiner-futurama-605825_640_476.jpg"],
    [/benderbrau/i, "http://www.liquidenjoyment.com/stuff/futurama/benderbrau.png"],
    [/hypnotoad/i, "http://www.liquidenjoyment.com/stuff/futurama/hypnotoad.gif"],
    [/brain[\s]?slug/i, "http://2.bp.blogspot.com/_rOe69ShWz1I/TRJo0KvGaJI/AAAAAAAAEcg/yWAL1fq3qbM/s1600/futurama-brain-slug.jpg"],
    [/bite my shiny metal/i, "http://www.deviantart.com/download/121673823/Futurama_Bender_Calculon_Fry_by_MightYst01.png"],
    [/robot oil/i, "http://theinfosphere.org/images/thumb/a/a4/Robot_Oil.jpg/225px-Robot_Oil.jpg"],
    [/\bmom\b/i, "http://static.tvfanatic.com/images/gallery/mom-picture.gif"]
  ]

end
