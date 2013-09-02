class Notation
  def self.save_game(game)

  end

  def self.other_direction(int)
    int == Constant.size ? 1 : Constant.size
  end

  def self.get_direction(char)
    char == 'v' ? Constant.size : 1
  end

  def self.id_to_coords(id)
    [id / Constant.size, id % Constant.size].map { |x| x + 1 }
  end

  def self.coords_to_id(coords)
    (coords[0].to_i - 1) * Constant.size + coords[1].to_i - 1
  end
end
