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
    [/\bthriller\b/i, "http://freddyo.com/wp-content/uploads/2010/03/jackson-lays-down-some-moves-in-the-zombie-dance-scene-from-his-1982-thriller-music-video-ct.jpg"],
    [/\bo[\s]?rly[\?]?/i, "http://memepics.com/wp-content/uploads/2011/05/ya-rly-owl.jpg"],
    [/\bmagnet(s)?\b/i, "http://img403.imageshack.us/img403/4757/ingmagnets.jpg"],
    [/\brent\b/i, "http://blog.rentaluniversity.com/wp-content/uploads/2010/10/Rent1.jpg"],
    [/\banonymous\b/i, "http://assets.motherboard.tv/post_images/assets/000/008/979/anonymous_large.jpg"],
    [/(\bcar trouble\b|\bcar problems\b|\bcar issue\b)/i, "http://www.towingsantarosaca.com/towingpetaluma/roadside-assistance-services-for-santa-rosa-bodega-bay-monte-rio-nido-ca.jpg"],
    [/\bbobby tables\b/i, "http://imgs.xkcd.com/comics/exploits_of_a_mom.png"],
    [/\bdevelopers developers\b/i, "http://www.everythingwm.com/wp-content/uploads/2010/11/developers-developers-developers.jpg"],
    [/(outlook(.)*suck|outlook(.)*crash|crash(.)*outlook|outlook(.)*error|error(.)*outlook|hate(.)*outlook|outlook(.)*hate)/i, "http://farm2.static.flickr.com/1110/5102961691_28b373e40b.jpg"],
    [/(\bblue[\s]?screen|bsod)/i, "http://www.hightech-edge.com/wp-content/uploads/unlicenese-windows-system-crash.jpg"],
    [/\bmassive dynamic\b/i, "http://1.bp.blogspot.com/-op-S2WhOqrU/TZp2DjdpVqI/AAAAAAAAAPQ/ErYyWi2ODlY/s320/MassiveDynamic.png"],
    [/\bunix\b/i, "http://img521.imageshack.us/img521/5259/jpunix.png"],
    [/\bschwartz\b/i, "http://verydemotivational.files.wordpress.com/2011/11/demotivational-posters-your-schwartz.jpg"],
    [/(\bi didn't do\b|\bi did nothing\b)/i, "http://verydemotivational.files.wordpress.com/2011/11/demotivational-posters-i-swear.jpg"],
    [/(\b3.14\b|\bpie\b)/i, "http://verydemotivational.files.wordpress.com/2011/11/demotivational-posters-mind-blown.jpg"],
    [/\bdibs\b/i, "http://verydemotivational.files.wordpress.com/2011/11/demotivational-posters-dibs1.jpg"],
    [/\bmordor\b/i, "http://verydemotivational.files.wordpress.com/2011/11/demotivational-posters-one-does-not-simply-occupy-mordor1.jpg"],
    [/\bbad day\b/i, "http://bios.weddingbee.com/pics/79942/BadDay.jpg"],
    [/\bprecious\b/i, "http://chzupnextinsports.files.wordpress.com/2010/12/funny-sports-pictures-my-precious.jpg"],
    [/\bmonday\b/i, "http://3.bp.blogspot.com/_OvmuvHN8HnM/SoBa6BAgmXI/AAAAAAAABb8/pUZ0ESreKZs/s400/Mondays.jpg"],
    [/\bsaturday\b/i, "http://images.icanhascheezburger.com/completestore/2009/1/27/128775669976738890.jpg"],
    [/\bserious\b/i, "http://i199.photobucket.com/albums/aa284/FriarReb98/Caturday/SeriousCat2.jpg"],
    [/\bthursday\b/i, "http://excusememe.com/pics/images/1301095266_thor-meets-rebecca-black-14742-1301090889-33.jpg"],
    [/\bbroke the build\b/i, "http://troll.me/images/y-u-no/the-build-why-you-broke-it.jpg"],
    [/\bwednesday\b/i, "http://i235.photobucket.com/albums/ee292/PalomaCortez/Happy-Wednesday.jpg"],
    [/\blearn ruby\b/i, ["Learn Ruby or DIE","http://img405.imageshack.us/img405/3670/yourlifecoulddependonit.jpg"],
    [/\bone of us\b/i, "http://img851.imageshack.us/img851/4459/oneofus.jpg"]
  ]

end
