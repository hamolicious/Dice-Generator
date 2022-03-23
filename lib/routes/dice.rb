require 'sinatra'
require_relative '.././utils'

# /dice
get generate_route(__FILE__) do
    @die_fill = '#' << get_param_str(params, 'diefill', '0F0F0F')
    @circle_fill = '#' << get_param_str(params, 'circlefill', 'F0F0F0')

    @size = get_param_int(params, 'size', 300)
    @corner_rad = get_param_int(params, 'cornerrad', (@size/10.0).to_i)
    @dice_roll = get_param_int(params, 'num', rand(1..6))

    grid_size = (@size / 3.0).to_i
    @circle_rad = ((grid_size/2) * (get_param_int(params, 'circlerad', 85) * 0.01)).to_i

    @circle_min = (grid_size * 1) - (grid_size / 2.0).to_i
    @circle_mid = (grid_size * 2) - (grid_size / 2.0).to_i
    @circle_max = (grid_size * 3) - (grid_size / 2.0).to_i

    @top_left =  [2, 3, 4, 5, 6].include?(@dice_roll) ? @circle_fill : @die_fill
    @top_right = [4, 5, 6].include?(@dice_roll)       ? @circle_fill : @die_fill
    @mid_left =  [6].include?(@dice_roll)             ? @circle_fill : @die_fill
    @mid_mid =   [1, 3, 5].include?(@dice_roll)       ? @circle_fill : @die_fill
    @mid_right = [6].include?(@dice_roll)             ? @circle_fill : @die_fill
    @bot_left =  [4, 5, 6].include?(@dice_roll)       ? @circle_fill : @die_fill
    @bot_right = [2, 3, 4, 5, 6].include?(@dice_roll) ? @circle_fill : @die_fill

    erb :dice
end