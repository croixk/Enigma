require 'date'

class Enigma

  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "
  end


  def encrypt(message, key = 0, date = Date)
    message = message.downcase

    if key == 0
      key = rand(99999)
    end

    #make key into 5 character string
    key_string = key.to_s.rjust(5)

    # produce (4) two digit int keys
    a_key = key_string[0, 2].to_i
    b_key = key_string[1, 2].to_i
    c_key = key_string[2, 2].to_i
    d_key = key_string[3, 2].to_i

    # square date - only keep last 4 digits
    date_square_4 = ((date.to_i)**2).to_s[-4,4]

    a_shift = date_square_4[0].to_i + a_key
    b_shift = date_square_4[1].to_i + b_key
    c_shift = date_square_4[2].to_i + c_key
    d_shift = date_square_4[3].to_i + d_key

    # split message into array
    message_array = message.split(//)

    # require "pry"; binding.pry

    encrypted_array = []
    # if, elsif, etc, for index position
    for i in 1..(message_array.length)
      if i%4 == 1   # a
        index = (i + a_shift)%27
        encrypted_array << @alphabet[index]
      elsif i%4 == 2 # b
        index = (i + b_shift)%27
        encrypted_array << @alphabet[index]
      elsif i%4 == 3 # c
        index = (i + c_shift)%27
        encrypted_array << @alphabet[index]
      elsif i%4 == 0 # d
        index = (i + d_shift)%27
        encrypted_array << @alphabet[index]
      end
    end

    require "pry"; binding.pry
    # return hash - 3 keys (encryption, key, date)
    encrypted_array
  end


  def decrypt(ciphertext, key, date)

  end

end
