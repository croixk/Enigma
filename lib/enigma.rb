require 'date'

class Enigma

  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "

  end

  # takes in argument for a-d shift, message_array,
    # returns character to add
  def encrypted_character(shift, message_array, i)
    alphabet_index = @alphabet.index(message_array[i])
    if(alphabet_index == nil)
      message_array[i]
    else
      new_index = (shift + alphabet_index)%27
      @alphabet[new_index]
    end
  end

  def decrypted_character(shift, message_array, i)
    alphabet_index = @alphabet.index(message_array[i])
    if(alphabet_index == nil)
      message_array[i]
    else
      new_index = (-shift + alphabet_index)%27
      @alphabet[new_index]
    end
  end

  def generate_shifts(key, date)
    if key == 0
      key = rand(99999)
    end

    if date == nil
      date = Date.today.strftime("%d%m%y")
      require "pry"; binding.pry
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

    shifts = [a_shift, b_shift, c_shift, d_shift]
  end

  def encrypt(message, key = 0, date = nil)

    # split message into lowercase array
    message_array = message.downcase.chars
    encrypted_array = []

    shifts = generate_shifts(key, date)

    for i in 0..(message_array.length - 1)
      if i%4 == 0   # a
        encrypted_array << encrypted_character(shifts[0], message_array, i)
      elsif i%4 == 1 # b
        encrypted_array << encrypted_character(shifts[1], message_array, i)
      elsif i%4 == 2 # c
        encrypted_array << encrypted_character(shifts[2], message_array, i)
      elsif i%4 == 3 # d
        encrypted_array << encrypted_character(shifts[3], message_array, i)
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

    # split message into array
    message_array = ciphertext.downcase.chars
    encrypted_array = []

    shifts = generate_shifts(key, date)

    for i in 0..(message_array.length - 1)
      if i%4 == 0   # a
        encrypted_array << decrypted_character(shifts[0], message_array, i)
      elsif i%4 == 1 # b
        encrypted_array << decrypted_character(shifts[1], message_array, i)
      elsif i%4 == 2 # c
        encrypted_array << decrypted_character(shifts[2], message_array, i)
      elsif i%4 == 3 # d
        encrypted_array << decrypted_character(shifts[3], message_array, i)
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
