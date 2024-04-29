require 'sneakers'

Sneakers.configure  daemonize: true,
                    amqp: Rails.configuration.amqp_url,
                    log: "log/sneakers.log",
                    pid_path: "tmp/pids/sneakers.pid",
                    threads: 1,
                    workers: 1
Sneakers.logger = Rails.logger
Sneakers.logger.level = Logger::WARN
