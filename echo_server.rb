#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'zmachine'

java_import org.zeromq.ZMQ

#set_trace_func proc { |event, file, line, id, binding, classname|
#  printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
#}

class EchoServer < ZMachine::Connection
  def receive_data(data)
    send_data(*data)
  end
end

ZMachine.run do
  ZMachine.start_server("tcp://*:10000", ZMQ::REP, EchoServer)
  puts "machine running"
end
