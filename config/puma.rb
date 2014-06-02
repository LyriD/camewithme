#!/usr/bin/env puma

environment 'development'
pidfile 'tmp/pids/puma.pid'
state_path 'tmp/pids/puma.state'
bind 'unix://tmp/sockets/puma.sock'

daemonize

on_restart do
   puts 'On restart...'
end
