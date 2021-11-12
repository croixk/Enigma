require './lib/enigma'

arguments = ARGV

key = ARGV[2]
date = ARGV[3]

encrypted_file = File.open('encrypted.txt', 'r')
read_encrypted = encrypted_file.read

enigma = Enigma.new

decrypted_file = File.open('decrypted.txt', 'w')

decrypted_file.write(enigma.decrypt(read_encrypted, key, date))

puts "Created #{ARGV[1]} with the key #{key} and date #{date}"
