# Run Your own Chat Bot on HipChat / Campfire

        Stable on ruby-1.8.7
        Testing on 1.9.2 / 1.9.3 looks good so far!

1. Copy config.yml.example to config.yml

        # config.yml

        ## SERVICES ##
        # Supported values: hipchat, campfire
        service: hipchat

        ## HIPCHAT SETTINGS ##
        hipchat:
          jid: DDDD_XXXXX@chat.hipchat.com
          name: Full Name
          password: <password>
          history: 3 # num of history fields to request
          rooms:
            - DDDD_room_name@conf.hipchat.com
            # - DDDD_second_room_name@conf.hipchat.com

        ## CAMPFIRE SETTINGS ##
        campfire:
          subdomain: subdomain  # from subdomain.campfirenow.com
          # auth_mode: Can use API key or username/password.
          # Supported values: api, username
          auth_mode: api
          api_key: api_key_goes_here  # enter if using "api" auth_mode
          username: username          # enter if using "username" auth_mode
          password: password          # also enter if using "username" auth_mode
          room: room_name             # only supports one room for campfire
          ssl: true

        ## BOT SETTINGS ##
        bot:
          hello: Mainframe: ONLINE
          goodbye: NO CARRIER

        ## PLUGIN SETTINGS ##
        enabled_plugins:
          - HipRepeater
          - RandomResponses

          - Archer
          - Bash
          - Futurama
          - LikeABoss
          - Olaf
          - PennyArcade
          - QuickMeme
          - WalMart
          - XKCD
          # - EpicFail
          # - FML
          # - TWSS

1. Add credentials to config.yml, configure plugins to load
1. Start the ISIS Daemon ``bin/isis run`` or in the background ``bin/isis start``

        Usage: isis <command> <options> -- <application options>

        * where <command> is one of:
          start         start an instance of the application
          stop          stop all instances of the application
          restart       stop all instances and restart them afterwards
