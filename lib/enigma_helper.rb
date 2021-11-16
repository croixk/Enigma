module EnigmaHelper
  # takes in argument for a-d shift, message_array, char index
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

  # similar to encrypted_character, but shift left
  def decrypted_character(shift, message_array, i)
    alphabet_index = @alphabet.index(message_array[i])
    if(alphabet_index == nil)
      message_array[i]
    else
      new_index = (-shift + alphabet_index)%27
      @alphabet[new_index]
    end
  end

  def shifted_character(shift, message_array, i, direction)
    alphabet_index = @alphabet.index(message_array[i])
    if(alphabet_index == nil)
      message_array[i]
    else
      new_index = (direction*shift + alphabet_index)%27
      @alphabet[new_index]
    end
  end

  # this method generates the a-d shifts, as well as date and key if needed
  def generate_shifts(key, date)
    if key == 0
      key = rand(99999)
    end

    if date == nil
      date = Date.today.strftime("%d%m%y")
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

    shifts = [a_shift, b_shift, c_shift, d_shift, key, date]
  end

end
