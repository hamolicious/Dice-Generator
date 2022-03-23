require 'sinatra'
require_relative './utils'

# setup filesystem
if !File.exists?(get_assets_path())
    Dir.mkdir(get_assets_path())
end

# setup sinatra
Dir.chdir(__dir__)
set :root,  File.dirname(__dir__)
set :views, Proc.new { File.join(__dir__, 'views') }
set :public_folder, get_assets_path()

# import routes
def get_all_endpoints(path, files=nil)
    files = [] if files == nil
    check = Dir.glob(File.join(path, '/**'))
    check.each { |f|
        files.push(f) if File.file?(f)
        get_all_endpoints(f, files=files) if !File.file?(f)
    }
    return files

end
get_all_endpoints('./routes/').each { |req|
    require_relative req
}


