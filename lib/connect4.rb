class Board
    attr_reader :board
    NUM_ROWS = 6
    NUM_COLUMNS = 7
    WIN_LENGTH = 4

    def initialize
        @board = Array.new(NUM_ROWS * NUM_COLUMNS, 0)
    end

    def get_pos(x,y)
        @board[y*NUM_COLUMNS + x]
    end

    def put_symbol_in_column(symbol, col)
        target = nil
        NUM_ROWS.times do |row|
            if get_pos(col,row) == 0
                target = x_y_to_index(col,row)
                break
            end
        end
        @board[target] = symbol if target 
    end

    def board_full?
        @board.none?{|pos| pos == 0}
    end

    def diagonal_winner
        #Bottom row
        NUM_COLUMNS.times do |x|
            res = array_winner(get_right_diagonal(x,0))
            return res if res
            res = array_winner(get_left_diagonal(x,0))
            return res if res
        end

        #Leftmost and rightmost columns
        NUM_ROWS.times do |y|
            res = array_winner(get_right_diagonal(0,y))
            return res if res
            res = array_winner(get_left_diagonal(NUM_COLUMNS - 1, y))
            return res if res
        end
        nil
    end

    def row_winner(row_num)
        row = get_row(row_num)
        array_winner(row)
    end

    def column_winner(col_num)
        col = get_col(col_num)
        array_winner(col)
    end

    def winner
        #Row winner
        NUM_ROWS.times do |row|
            res = row_winner(row)
            return res if res
        end
        #Column winner
        NUM_COLUMNS.times do |col|
            res = column_winner(col)
            return res if res
        end

        #Diagonal winner
        res = diagonal_winner
        return res if res
        nil
    end

    def get_printable_board
        result = ""
        (NUM_ROWS - 1).downto(0) do |row_num|
            row = get_row(row_num)
            row.map! {|symbol| symbol == 0 ? " " : symbol}
            result += "|" + row.join("|") + "|\n"
        end
        result += "|" + (0...NUM_COLUMNS).to_a.join("|") + "|"
    end    
    
    private
    #Check all length WIN_LENGTH sub-arrays of array for WIN_LENGTH in a row
    def array_winner(array)
        0.upto(array.length - WIN_LENGTH) do |start|
            sub = array[start...start+WIN_LENGTH]
            if sub.uniq.size == 1 && sub[0] != 0
                return sub[0]
            end
        end
        nil
    end

    def get_right_diagonal(start_x, start_y)
        result = []
        x = start_x
        y = start_y
        target = get_pos(x, y)
        while target
            result << target
            x += 1
            y += 1
            target = get_pos(x, y)
        end
        result
    end

    def get_left_diagonal(start_x, start_y)
        result = []
        x = start_x
        y = start_y
        target = get_pos(x, y)
        while target
            result << target
            x -= 1
            y += 1
            target = get_pos(x,y)
        end
        result
    end

    def x_y_to_index(x,y)
        y * NUM_COLUMNS + x
    end

    def get_row(row)
        @board[NUM_COLUMNS*row...NUM_COLUMNS*(row + 1)]
    end

    def get_col(col)
        col_arr = []
        NUM_ROWS.times do |row|
            col_arr << get_pos(col,row)
        end
        col_arr
    end
end