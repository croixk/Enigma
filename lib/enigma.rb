require 'date'

class Enigma

  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "
  end


  def encrypt(message, key = 0, date = Date.today)
    message = message.downcase

    if key == 0
      key = rand(99999)
    end

    #make key into 5 character string
    key_string = key.to_s.rjust(5)
    # do i need (5, "0")


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
    encrypted_array = []

    for i in 0..(message_array.length - 1)
      if i%4 == 0   # a
        alphabet_index = @alphabet.index(message_array[i])
        new_index = (a_shift + alphabet_index)%27

        encrypted_array << @alphabet[new_index]
      elsif i%4 == 1 # b
        alphabet_index = @alphabet.index(message_array[i])
        new_index = (b_shift + alphabet_index)%27

        encrypted_array << @alphabet[new_index]
      elsif i%4 == 2 # c
        alphabet_index = @alphabet.index(message_array[i])
        new_index = (c_shift + alphabet_index)%27

        encrypted_array << @alphabet[new_index]
      elsif i%4 == 3 # d
        alphabet_index = @alphabet.index(message_array[i])
        new_index = (d_shift + alphabet_index)%27

        encrypted_array << @alphabet[new_index]
      end
    end

    # return hash - 3 keys (encryption, key, date)
    encrypted_hash = {}
    encrypted_hash[:date] = date
    encrypted_hash[:encryption] = encrypted_array.join
    encrypted_hash[:key] = key
    encrypted_hash
  end


  def decrypt(ciphertext, key = 0, date = Date)
    ciphertext = ciphertext.downcase

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
    message_array = ciphertext.split(//)
    encrypted_array = []

    for i in 0..(message_array.length - 1)
      if i%4 == 0   # a
        alphabet_index = @alphabet.index(message_array[i])
        new_index = (-a_shift + alphabet_index)%27
        if new_index < 0
          new_index = 27 + new_index
        end
        encrypted_array << @alphabet[new_index]
      elsif i%4 == 1 # b
        alphabet_index = @alphabet.index(message_array[i])
        new_index = (-b_shift + alphabet_index)%27
        if new_index < 0
          new_index = 27 + new_index
        end
        encrypted_array << @alphabet[new_index]
      elsif i%4 == 2 # c
        alphabet_index = @alphabet.index(message_array[i])
        new_index = (-c_shift + alphabet_index)%27
        if new_index < 0
          new_index = 27 + new_index
        end
        encrypted_array << @alphabet[new_index]
      elsif i%4 == 3 # d
        alphabet_index = @alphabet.index(message_array[i])
        new_index = (-d_shift + alphabet_index)%27
        if new_index < 0
          new_index = 27 + new_index
        end
        encrypted_array << @alphabet[new_index]
      end
    end

    # return hash - 3 keys (encryption, key, date)
    encrypted_hash = {}
    encrypted_hash[:date] = date
    encrypted_hash[:decryption] = encrypted_array.join
    encrypted_hash[:key] = key
    encrypted_hash
  end

end
