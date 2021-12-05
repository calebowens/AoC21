require 'enumerator'
require 'matrix'

class BingoBoard
    def initialize (representation)
        @representation = Matrix[*representation]
        @called_slots = Matrix.build(5, 5) { | x, y | false }
    end

    def call (number)
        @representation.each_with_index do | element, x, y |
            if element == number
                @called_slots[x, y] = true
            end
        end
    end

    def called_row ()
        out = false

        @called_slots.row_vectors.each do | row |
            out ||= row.reduce { | accumuator, value | accumuator && value }
        end

        @called_slots.transpose.row_vectors.each do | row |
            out ||= row.reduce { | accumuator, value | accumuator && value }
        end

        out
    end

    def sum ()
        out = 0

        @called_slots.each_with_index do | element, x, y |
            if !element
                out += @representation[x, y]
            end
        end

        out
    end
end

calls = File.open('./four_calls.txt')
    .readlines(chomp: true)
    .first
    .split(',')
    .map(&:to_i)

boards = []
File.open('./four_boards.txt')
    .readlines(chomp: true)
    .filter { | line | line != '' }
    .map { | line | line.split.map(&:to_i) }
    .each_slice(5) { | rows | boards << BingoBoard.new(rows) }

winning_value = 0
last_winning = 0

calls.each do | number |
    boards.map! do | board |
        board.call(number)

        if board.called_row()
            if winning_value == 0
                winning_value = board.sum() * number
            end
            last_winning = board.sum() * number
        end

        board
    end

    boards.filter! { | board | !board.called_row() }
end

puts winning_value, last_winning