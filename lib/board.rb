class Field
  attr_accessor :label

  def initialize(label)
    @label = label
  end

  def blank?
    @label == ''
  end

  def occuppied?
    Constant.main_regex =~ @label
  end

  def has_label?
    /[23\*]/ =~ @label[0]
  end
end

class Board
  attr_reader :fields

  def initialize
    @fields = []
    (Constant.all_fields).times do |id|
      @fields << Field.new(field_label(id))
    end
  end

  private

  def field_label(id)
    coords = Notation.id_to_coords(id)
    Constant.bonuses.each { |label, value| return label if value.member? coords }
    ''
  end
end
