require_relative './enigma'
require_relative './enigma_helper'
require_relative './crack_helper'

arguments = ARGV

key = "11111"
date = "040895"

message_file = File.open('message.txt', 'r')
read_message = message_file.read

enigma = Enigma.new

encrypted_file = File.open('encrypted.txt', 'w')

encrypted_message = enigma.encrypt(read_message, key, date)[:encryption]

encrypted_file.write(encrypted_message)

puts "Created #{ARGV[1]} with the key #{key} and date #{date}"
