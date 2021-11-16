module CrackHelper

  # pos_shift is equal to shift for each letter - need to assign to a, b, c, d
    # this uses length of array to determine which letter in " end" is which shift

  def generate_crack_shifts(length, pos_shifts)
    shift_hash = Hash.new

    if (length % 4) == 0
      shift_hash["a_shift"] = pos_shifts[0]
      shift_hash["b_shift"] = pos_shifts[1]
      shift_hash["c_shift"] = pos_shifts[2]
      shift_hash["d_shift"] = pos_shifts[3]

    elsif (length % 4) == 1
      shift_hash["b_shift"] = pos_shifts[0]
      shift_hash["c_shift"] = pos_shifts[1]
      shift_hash["d_shift"] = pos_shifts[2]
      shift_hash["a_shift"] = pos_shifts[3]

    elsif (length % 4) == 2
      shift_hash["c_shift"] = pos_shifts[0]
      shift_hash["d_shift"] = pos_shifts[1]
      shift_hash["a_shift"] = pos_shifts[2]
      shift_hash["b_shift"] = pos_shifts[3]

    elsif (length % 4) == 3
      shift_hash["d_shift"] = pos_shifts[0]
      shift_hash["a_shift"] = pos_shifts[1]
      shift_hash["b_shift"] = pos_shifts[2]
      shift_hash["c_shift"] = pos_shifts[3]
    end

    shift_hash
  end

  def generate_key(poss_keys_s)
    # this loop is the critical piece of code to figure out which key values are
    # the ones that together form the 5 digit key. It utilizes the overlap between
    # the 5 two digit keys to eliminate 2 digit key possibilities that don't share values
    # with adjacent keys. For example, the last digit of the first two digit key
    # must be the same as the first digit of the b key - if there isn't a b key that starts
    # with that a key last letter the a key can be eliminated

    # this is repeated until there is only one element in each array of possible values
    while poss_keys_s["a"].length > 1 || poss_keys_s["b"].length > 1 || poss_keys_s["c"].length > 1 || poss_keys_s["d"].length > 1
      # keep a's that end with a first letter of b
      a_key_new = []
      poss_keys_s["a"].each do |a_key|
        holder = []
        poss_keys_s["b"].each do |b_key|
          holder << b_key[0]
        end
        if holder.include?(a_key[1])
          a_key_new << a_key
        end
      end
      poss_keys_s["a"] = a_key_new

      # keep b's that start with last letter of a's
      b_key_new = []
      poss_keys_s["b"].each do |b_key|
        holder = []
        poss_keys_s["a"].each do |a_key|
          holder << a_key[1]
        end
        if holder.include?(b_key[0])
          b_key_new << b_key
        end
      end
      poss_keys_s["b"] = b_key_new

      b_key_new = []
      poss_keys_s["b"].each do |b_key|
        holder = []
        poss_keys_s["c"].each do |c_key|
          holder << c_key[0]
        end
        if holder.include?(b_key[1])
          b_key_new << b_key
        end
      end
      poss_keys_s["b"] = b_key_new

      c_key_new = []
      poss_keys_s["c"].each do |c_key|
        holder = []
        poss_keys_s["b"].each do |b_key|
          holder << b_key[1]
        end
        if holder.include?(c_key[0])
          c_key_new << c_key
        end
      end
      poss_keys_s["c"] = c_key_new

      c_key_new = []
      poss_keys_s["c"].each do |c_key|
        holder = []
        poss_keys_s["d"].each do |d_key|
          holder << d_key[0]
        end
        if holder.include?(c_key[1])
          c_key_new << c_key
        end
      end
      poss_keys_s["c"] = c_key_new

      d_key_new = []
      poss_keys_s["d"].each do |d_key|
        holder = []
        poss_keys_s["c"].each do |c_key|
          holder << c_key[1]
        end
        if holder.include?(d_key[0])
          d_key_new << d_key
        end
      end
      poss_keys_s["d"] = d_key_new

    end

    key = poss_keys_s["a"][0].to_s + poss_keys_s["b"][0][1].to_s + poss_keys_s["c"][0][1].to_s + poss_keys_s["d"][0][1].to_s

  end

end
