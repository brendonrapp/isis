# Run Your own Chat Bot on HipChat / Campfire

        Stable on ruby-1.8.7
        Random crashes on /some/ Hipchat Broadcast messages on ruby-1.9.3

1. Copy config.yml.example to config.yml
1. Add credentials to config.yml, configure plugins to load
1. Start isis in the foreground ``bin/isis run`` or in the background ``bin/isis start``

        Usage: isis <command> <options> -- <application options>
        
        * where <command> is one of:
          start         start an instance of the application
          stop          stop all instances of the application
          restart       stop all instances and restart them afterwards
          reload        send a SIGHUP to all instances of the application
          run           start the application and stay on top
          zap           set the application to a stopped state
          status        show status (PID) of application instances
        
        * and where <options> may contain several of the following:
        
            -t, --ontop                      Stay on top (does not daemonize)
            -f, --force                      Force operation
            -n, --no_wait                    Do not wait for processes to stop
        
        Common options:
            -h, --help                       Show this message
                --version                    Show version
