def get_assets_path
    return File.join(__dir__, 'assets')
end

def generate_route(filename)
    return filename.reverse.chomp(File.join(__dir__, 'routes').reverse).reverse.chomp('.rb')
end

def get_param_str(params, name, default)
    return params.fetch(name, default)
end

def get_param_int(params, name, default)
    return params.fetch(name, default).to_i
end
