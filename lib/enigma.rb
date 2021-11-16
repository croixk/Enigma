require 'date'
require './enigma_helper'
require './crack_helper'

class Enigma
  include EnigmaHelper
  include CrackHelper

  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def encrypt(message, key = 0, date = nil)
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
    encrypted_hash[:date] = shifts[5]
    encrypted_hash[:encryption] = encrypted_array.join
    encrypted_hash[:key] = shifts[4]
    encrypted_hash
  end

  def decrypt(ciphertext, key = 0, date = nil)
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

    encrypted_hash = {}
    encrypted_hash[:date] = shifts[5]
    encrypted_hash[:decryption] = encrypted_array.join
    encrypted_hash[:key] = shifts[4]
    encrypted_hash
  end



  def crack(ciphertext, date = nil)
    message_array = ciphertext.downcase.chars
    length = message_array.length
    known = [" ", "e", "n", "d"]

    last_four = message_array[-4,4]
    shifts = []

    # calculate shifts for each of last four characters (" end")
    last_four.each_with_index do |char, index|
      shifts << (@alphabet.index(char) - @alphabet.index(known[index]))
    end

    # add to pos shifts - convert to positive shift if shift is negative
      # a positive shift is 27 + the negative number, if negative
    pos_shifts = []
    shifts.each do |shift|
      if shift < 0
        pos_shift = shift + 27
        pos_shifts << pos_shift
      else
        pos_shifts << shift
      end
    end

    shift_hash = generate_crack_shifts(length, pos_shifts)

    if date == nil
      date = Date.today.strftime("%d%m%y")
    end

    # square date - only keep last 4 digits
    date_square_4 = ((date.to_i)**2).to_s[-4,4]

    # calculate possible keys by subtracting date digit from shift
    a_key = shift_hash["a_shift"] - date_square_4[0].to_i
    b_key = shift_hash["b_shift"] - date_square_4[1].to_i
    c_key = shift_hash["c_shift"] - date_square_4[2].to_i
    d_key = shift_hash["d_shift"] - date_square_4[3].to_i

    # make emptry arrays for possible key values (since they can also be
      # 27 higher than calculated shift
      # need one for ints, one for strings (to add leading zeros)

    poss_keys = Hash.new()
    poss_keys["a"] = [a_key]
    poss_keys["b"] = [b_key]
    poss_keys["c"] = [c_key]
    poss_keys["d"] = [d_key]

    poss_keys.each do |key, value|
      while value.last <= 81
        value << value.last + 27
      end
    end

    poss_keys_s = Hash.new

    poss_keys.each do |key, value|
      poss_keys_s[key] = []
      value.each do |value|
        poss_keys_s[key] << value.to_s.rjust(2, "0")
      end
    end

    key = generate_key(poss_keys_s)

    decrypt(ciphertext, key, date)
  end

end
