require 'date'
require './lib/enigma'
require 'spec_helper'

RSpec.describe Enigma do

  it 'exists' do
    enigma = Enigma.new
    expect(enigma).to be_instance_of(Enigma)
  end

  it 'encrypted_character' do
    enigma = Enigma.new
    expect(enigma.encrypted_character(1, ["a"], 0)).to eq("b")
    expect(enigma.encrypted_character(1, ["?"], 0)).to eq("?")
  end

  it 'decrypted_character' do
    enigma = Enigma.new
    expect(enigma.decrypted_character(1, ["b"], 0)).to eq("a")
    expect(enigma.decrypted_character(1, ["?"], 0)).to eq("?")
  end


  it 'encrypt method' do
    enigma = Enigma.new
    expected = {encryption: "keder ohulw", key: "02715", date: "040895"}

    expect(enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
  end

  it 'decrypt method' do
    enigma = Enigma.new
    expected =  {decryption: "hello world", key: "02715", date: "040895"}

    expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
  end


  ## add tests for uppercase letters, special characters - all edge cases

end
