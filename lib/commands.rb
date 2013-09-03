class Command
  def self.execute(command)
    command.downcase.force_encoding('utf-8')
    case
    when command[0] == 'h'
      ['print_help']
    when command[0] == 't'
      ['print_all_tiles']
    when command[0] == 'q'
      ['force_game_over']
    when command[0] == 's'
      ['swap_tiles', command]
    when Constant.writing_regex =~ command
      ["word_controller", command]
    else
      ['print_error', 0]
    end
  end

  def self.parse_word(command)
    start_position, direction, letters = command.split(' ')
    return Notation.coords_to_id(start_position.split(',')), letters.split(''),
    Notation.get_direction(direction)
  end

  def self.parse_swap(command)
    prefix, word = command.split(' ')
    return false if word.empty?
    word.split('')
  end
end

