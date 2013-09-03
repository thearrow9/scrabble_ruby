class Command
  def self.execute(command)
    command.downcase.force_encoding('utf-8')
    case
    when command[0] == 'h'
      ['print_help']
    when command[0] == 's'
      ['save_game']
    when Constant.cmd_regex =~ command
      ["word_controller", command]
    else
      ['not_found']
    end
  end

  def self.parse(command)
    start_position, direction, letters = command.split(' ')
    return Notation.coords_to_id(start_position.split(',')), letters.split(''),
    Notation.get_direction(direction)
  end
end

