get generate_route(__FILE__) do

    @die_fill = '#' << get_param_str(params, 'diefill', '0F0F0F')
    @circle_fill = '#' << get_param_str(params, 'circlefill', 'F0F0F0')

    @size = get_param_int(params, 'size', 300)
    @corner_rad = get_param_int(params, 'cornerrad', (@size/10.0).to_i)
    @dice_roll = get_param_int(params, 'num', rand(1..6))

    grid_size = (@size / 3.0).to_i
    @circle_rad = ((grid_size/2) * (get_param_int(params, 'circlerad', 85) * 0.01)).to_i

    erb :doc_dice
end