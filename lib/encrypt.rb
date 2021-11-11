require './lib/enigma'


ARGV == [message, encrypted_txt]
message_file = File.open(message, "r")

require "pry"; binding.pry
