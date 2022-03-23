require 'sinatra'
require_relative '.././utils'
require 'digest'

def digest_params(params)
    return Digest::MD5.hexdigest(params.inspect())
end

def is_cached?(params)
    return File.exist?(digest_params(params))
end

def generate_die(params)
    @die_fill = '#' << get_param_str(params, 'diefill', '0F0F0F')
    @circle_fill = '#' << get_param_str(params, 'circlefill', 'F0F0F0')

    @size = get_param_int(params, 'size', 300)
    @corner_rad = get_param_int(params, 'cornerrad', (@size * (get_param_int(params, 'circlerad', 20) * 0.01)).to_i)
    @dice_roll = get_param_int(params, 'num', 5)

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

    string = %[<?xml version="1.0" standalone="no"?>
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg width="#{@size}" height="#{@size}" xmlns="http://www.w3.org/2000/svg" xmlns:xlink= "http://www.w3.org/1999/xlink">
        <rect width="#{@size}" height="#{@size}" rx="#{@corner_rad}" style="fill:#{@die_fill}"/>
        <circle cx = "#{@circle_min}" cy = "#{@circle_min}" r="#{@circle_rad}" style="fill:#{@top_left}"></circle>
        <circle cx = "#{@circle_max}" cy = "#{@circle_min}" r="#{@circle_rad}" style="fill:#{@top_right}"></circle>
        <circle cx = "#{@circle_min}" cy = "#{@circle_mid}" r="#{@circle_rad}" style="fill:#{@mid_left}"></circle>
        <circle cx = "#{@circle_mid}" cy = "#{@circle_mid}" r="#{@circle_rad}" style="fill:#{@mid_mid}"></circle>
        <circle cx = "#{@circle_max}" cy = "#{@circle_mid}" r="#{@circle_rad}" style="fill:#{@mid_right}"></circle>
        <circle cx = "#{@circle_min}" cy = "#{@circle_max}" r="#{@circle_rad}" style="fill:#{@bot_left}"></circle>
        <circle cx = "#{@circle_max}" cy = "#{@circle_max}" r="#{@circle_rad}" style="fill:#{@bot_right}"></circle>
    </svg>
    ]

    return string
end


# /dice
get generate_route(__FILE__) do
    content_type 'image/svg+xml'

    path = File.join(get_assets_path(), "#{digest_params(params)}.svg")
    if !is_cached?(params)
        svg = generate_die(params)
        file = File.open(path, 'w')
        file.write(svg)
    end

    file.close()
    send_file(path)
end