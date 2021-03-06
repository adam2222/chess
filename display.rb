require "colorize"

require "io/console"
require_relative "board"
require_relative "cursorable"

class Display
  include Cursorable


  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected = false
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
      # puts row
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      chars = piece.nil? ? " " : piece.to_s
      chars.colorize(color_options)
      # p "test_string".colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd? # gonna need something like this for piece color
      bg = :cyan
    # else
    #   bg = :blue
    end
    { background: bg, color: :black }
  end

  def render
    system("clear")

    puts "  #{('A'..'H').to_a.join(" ")}"

    build_grid.each_with_index { |row, i| puts "#{i} #{row.join(" ")}" }
  end
end
