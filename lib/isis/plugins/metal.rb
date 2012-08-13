require 'isis/plugins/base'

class Isis::Plugin::Metal < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    /\bmetal\b/i =~ msg
  end

  def response
    "#{RESPONSES[rand(RESPONSES.size)]}"
  end

  RESPONSES = [
    ["METAL FACE", "http://img834.imageshack.us/img834/5195/metalface.jpg"],
    "http://metalmotivation.com/wp-content/uploads/fistfulofmetal.jpg",
    "http://4.bp.blogspot.com/_QL6KeWBaxlM/TJgI3nDrcOI/AAAAAAAAAAU/eJDl10y5fbo/s1600/Heavy+Metal.jpg",
    "http://images2.layoutsparks.com/1/119240/heavy-metal-words-image.jpg",
    "http://images.wikia.com/wherethedevilhornsbelong/images/6/6b/Heavy-metal-heavy-metal-crippled-demotivational-poster-1205483781.jpg",
    "http://blog.volucris.nl/wp-content/uploads/2008/12/heavy-metal_400.gif",
    "http://a2.ec-images.myspacecdn.com/images02/139/98dab8e2fe8c4a48b55770b736808c67/l.jpg",
    "http://profile.ultimate-guitar.com/profile_mojo_data/3/3/3/5/333515/pics/_c117447_image_0.gif",
    "http://farm4.static.flickr.com/3569/3389141131_79e11f71cb.jpg",
    "http://farm3.static.flickr.com/2091/2484158201_0c5e5d1e88.jpg",
    "http://www.bestmotivationalposters.com/images/black-metal-funny-motivational-poster.jpg",
    "http://images.paraorkut.com/img/funnypics/images/h/heavy_metal-12978.jpg",
    "http://funnydemotivationalposters.com/uploads/saved_posters/demotivational-poster-2534zh4i4q-METAL.jpg",
    "http://edge.ebaumsworld.com/mediaFiles/picture/593011/947558.jpg",
    "http://media.fakeposters.com/results/2009/07/17/8uklioorvs.jpg",
    "http://www.fairfaxunderground.com/forum/file.php?40,file=22643,filename=Heavy_Metal_Cat.jpg",
    "http://i183.photobucket.com/albums/x46/nikoslinaris/MetalCat.gif",
    "http://i249.photobucket.com/albums/gg237/thefoo1/metal-cat.jpg",
    "http://ecx.images-amazon.com/images/I/41AP6X6BS5L._SL500_AA300_.jpg",
    "http://img.chan4chan.com/img/2010-02-02/heavy-metal-satan-fingers-heavy-metal-713306_600_750.jpg",
    "http://1.bp.blogspot.com/_EDFv7RAPuUg/TNxCPd-JjOI/AAAAAAAAAMo/Xg6wZCbk_Kc/s1600/heavy_metal.jpg",
    "http://4.bp.blogspot.com/_EDFv7RAPuUg/TNxCPhp_7JI/AAAAAAAAAMw/NsckMfh9YNU/s1600/92036971.jpg",
    "http://music.blurtit.com/var/question/q/q8/q83/q830/q8302/q830216_1022602_heavy_metal.jpg",
    "http://1.bp.blogspot.com/_TsrnYkza_40/STxZTcRBH5I/AAAAAAAACKY/g2R4ywtd1oE/s400/Heavy_Metal.jpg",
    "http://api.ning.com/files/VrO5RvCgXCDoxwf*vTqK*MT2X3155VXNC9oN5NSXXi6K0Mc7vJ6N9gH3T1pa1HvLh2hVey-qg-HIU1HU5At6cKYYDaW1PSuv/HeavyMetal.jpg",
    "http://bbsimg.ngfiles.com/14/15594000/ngbbs47c372079f337.jpg",
    "http://cityrag.blogs.com/photos/uncategorized/2008/04/11/heavy_metal.jpg",
    "http://gatesthecomic.com/wp-content/uploads/2011/01/Ronnie-James-Dio-hal-hefner-heavy-metal-gates-the-comic.jpg",
    "http://steffmetal.com/wp-content/uploads/2009/11/miley-cyrus-metal-horns.jpg",
    "http://www.overthinkingit.com/wp-content/uploads/2010/05/dio_horns.jpg",
    "http://www.overthinkingit.com/wp-content/uploads/2010/05/ThrowTheHorns_DLF.jpg",
    "http://www.overthinkingit.com/wp-content/uploads/2010/05/metal_horns.jpg",
    "http://2.bp.blogspot.com/_s3xbijO-EDM/TRjK4-vMXbI/AAAAAAAAB68/xzCXAisg9FY/s1600/Sheila%2BDad%2BHorns%2BUp%2BRocks.jpg",
    "http://3.bp.blogspot.com/_5tY-XfbgJe0/SC5EMjE0_1I/AAAAAAAAArc/1HwmCaaC5BQ/s320/Picture+1.png",
    "http://www.metalfan.ro/images/foto_nr77/sabina%20horns%20mic.jpg",
    "http://i777.photobucket.com/albums/yy56/innocentbakerboy/Motivationals/death_metal_chicks.jpg",
    "http://i147.photobucket.com/albums/r316/futrprnstr69/Allagesconcertblvd07019.jpg",
    "http://www.backstreet-merch.com/images/products/bands/clothing/eaod/bsi_eaod19.gif",
    "http://www.comparestoreprices.co.uk/images/la/lava-the-kids-want-metal-girls-t-shirt.jpg",
    "http://samphillips.co.nz/assets/Uploads/_resampled/SetWidth487-metal-girls.jpg",
    "http://1.bp.blogspot.com/_pYoxd4dhbVw/TSHAArIPpjI/AAAAAAAAAuM/uNLt3oW7Hhc/S170/godlistenstoslayer.jpg",
    "http://www.blogcdn.com/www.popeater.com/media/2010/05/ronniejamesdio2-1274055004.jpg",
    "http://www.shugarecords.com/images/records/a6495b68-6eaa-4f89-8053-64dff207f9e2-0.JPG",
    "http://www.christchurchmusic.org.nz/files/u761/metallica_chch_Sept10.jpg",
    "http://gatesthecomic.com/wp-content/uploads/2011/01/ronnie-james-dio-hal-hefner-gates-the-comic-heavy-metal.jpg",
    "http://fc08.deviantart.net/fs19/f/2007/293/d/3/God_Listens_to_Slayer_by_money666mo.jpg"
  ]
end
