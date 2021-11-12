require './lib/enigma'

message_file = File.open('message.txt', 'r')
read_message = message_file.read

enigma = Enigma.new


puts encrypted = enigma.encrypt(read_message, "02715", "040895")

encrypted_file = File.open('encrypted.txt', 'w')
encrypted_file.write(enigma.encrypt(read_message, "02715", "040895"))


ARGV == ['message.txt', 'encrypted.txt']
