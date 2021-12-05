require 'matrix'

file = File.open('./five.txt')

class Instruction
    attr_accessor :to
    attr_accessor :from

    def initialize (input)
        parts = input.split("->").map do | part |
            parsed_part = part.split(',').map(&:to_i)
            Complex.rect(*parsed_part)
        end
        
        @to = parts[0]
        @from = parts[1]
    end

    def gradient
        (@to - @from).arg
    end

    def diagonal?
        case gradient()
        when Math::PI / 4
            true
        when (Math::PI / 4) * 3
            true
        when -Math::PI / 4
            true
        when -(Math::PI / 4) * 3
            true
        else
            false   
        end
    end
end

class PixelBoard
    def initialize
        @board = Matrix.build(1000, 1000) { |x, y| 0 }
    end

    def draw_line (instruction)
        x0 = instruction.to.real
        y0 = instruction.to.imag
        x1 = instruction.from.real
        y1 = instruction.from.imag

        brezenhams(x0, y0, x1, y1)
    end

    def overlaps
        overlaps = 0

        @board.each do | element |
            if element > 1
                overlaps += 1
            end
        end

        overlaps
    end

private

    # Taken from psudocode on wikipedia
    def brezenhams (x0, y0, x1, y1)
        dx =  (x1 - x0).abs
        sx = x0 < x1 ? 1 : -1
        dy = -(y1 - y0).abs
        sy = y0 < y1 ? 1 : -1
        err = dx + dy
        while true
            plot(x0, y0)
            break if x0 == x1 && y0 == y1
            e2 = 2 * err
            if e2 >= dy
                err += dy
                x0 += sx
            end
            if e2 <= dx
                err += dx
                y0 += sy
            end
        end
    end

    def plot (x, y)
        @board[x, y] = @board[x, y] + 1
    end
end

instructions = file.readlines(chomp: true)
    .map { | instruction | Instruction.new(instruction) }

straight_board = PixelBoard.new()

instructions.filter { | instruction | !instruction.diagonal? }
    .each { | instruction | straight_board.draw_line(instruction) }

puts straight_board.overlaps()

all_board = PixelBoard.new()

instructions.each { | instruction | all_board.draw_line(instruction) }

puts all_board.overlaps()