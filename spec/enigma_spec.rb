require 'date'
require './lib/enigma'
require 'spec_helper'

RSpec.describe Enigma do


    ## add tests for uppercase letters, special characters - all edge cases

  it 'exists' do
    enigma = Enigma.new
    expect(enigma).to be_instance_of(Enigma)
  end

  it 'encrypted_character' do
    enigma = Enigma.new
    expect(enigma.encrypted_character(1, ["a"], 0)).to eq("b")
    expect(enigma.encrypted_character(1, ["?"], 0)).to eq("?")
    expect(enigma.encrypted_character(1, ["a", "b", "c", "d"], 2)).to eq("d")
  end

  it 'decrypted_character' do
    enigma = Enigma.new
    expect(enigma.decrypted_character(1, ["b"], 0)).to eq("a")
    expect(enigma.decrypted_character(1, ["?"], 0)).to eq("?")
    expect(enigma.decrypted_character(1, ["a", "b", "c", "d"], 2)).to eq("b")
  end

  it 'generate_shifts' do
    enigma = Enigma.new
    expect(enigma.generate_shifts("02715", "040895")).to eq([3, 27, 73, 20, "02715", "040895"])
  end

  it 'encrypt method' do
    enigma = Enigma.new
    expected = {encryption: "keder ohulw", key: "02715", date: "040895"}

    expect(enigma.encrypt("hello world", "02715", "040895")).to eq(expected)

    # test special characters, capital letters
    expected = {:date=>"040895", :encryption=>"wekm@@!112", :key=>"02715"}
    expect(enigma.encrypt("TEST@@!112", "02715", "040895")).to eq(expected)
  end

  it 'decrypt method' do
    enigma = Enigma.new
    expected =  {decryption: "hello world", key: "02715", date: "040895"}

    expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)

    # test special characters
    expected =  {decryption: "test@@!112", key: "02715", date: "040895"}
    expect(enigma.decrypt("wekm@@!112", "02715", "040895")).to eq(expected)
  end

  it 'generate crack shifts' do
    enigma = Enigma.new
    length = 15
    pos_shifts = [8, 14, 5, 5]
    expected = {"a_shift"=>14, "b_shift"=>5, "c_shift"=>5, "d_shift"=>8}
    expect(enigma.generate_crack_shifts(length, pos_shifts)).to eq(expected)

  end


  it 'generate key' do
    enigma = Enigma.new
    poss_keys_s = {"a"=>["08", "35", "62", "89"],
      "b"=>["02", "29", "56", "83"],
      "c"=>["03", "30", "57", "84"],
      "d"=>["04", "31", "58", "85"]}
    expected = "08304"
    expect(enigma.generate_key(poss_keys_s)).to eq(expected)

  end

  it 'crack' do
    enigma = Enigma.new

    # this is from project description
    expected = {decryption: "hello world end", date: "291018", key: "08304"}
    expect(enigma.crack("vjqtbeaweqihssi", "291018")).to eq(expected)

    # this is my own message
    expected = {decryption: "hello, my name is croix. i am a student at turing end", date: "040895", key: "02715"}
    expect(enigma.crack("keder,sfa fupesbv vkrip.cisup ttvtmxhnltdtsmxragj xgg", "040895")).to eq(expected)

    # test just " end"
    expected = {decryption: " end", date: "040895", key: "02715"}
    expect(enigma.crack("cefx", "040895")).to eq(expected)

    # make sure it works for a repetitive key
    expected = {decryption: "one more test! end", date: "040895", key: "11111"}
    expect(enigma.crack(" yrpyzduldrhe!muzo", "040895")).to eq(expected)

  end

end
