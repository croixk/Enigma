require './lib/enigma'

arguments = ARGV

key = "02715"
date = "040895"

message_file = File.open('message.txt', 'r')
read_message = message_file.read

enigma = Enigma.new



encrypted_file = File.open('encrypted.txt', 'w')



encrypted_file.write(enigma.encrypt(read_message, key, date))

puts "Created #{ARGV[1]} with the key #{key} and date #{date}"
