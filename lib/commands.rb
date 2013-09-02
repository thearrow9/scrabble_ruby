class Command
  def self.execute(command)
    case
    when command[0] == 'h'
      ['print_help']
    when command[0] == 's'
      ['save_game']
    when /([1[0-5]|[1-9]],[1[0-5]|[1-9]])\s(v|h)\s(\p{Cyrillic})+/i =~ command
      ["word_controller", command]
    else
      ['not_found']
    end
  end

  def self.parse(command)
    start_position, direction, letters = command.split(' ')
    return Notation.coords_to_id(start_position.split(',')), letters.downcase.split(''),
    Notation.get_direction(direction.downcase)
  end
end

