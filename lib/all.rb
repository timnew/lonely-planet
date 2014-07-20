require 'pry'
require 'pry-debugger'
require 'awesome_print'
require 'active_support/all'

require 'nokogiri'
require 'haml'

def setup_autoload(*dirs)  
  dirs.flatten!

  root_path = File.dirname(__FILE__)  

  paths = dirs.map{|d| File.join(root_path, d) }  

  ActiveSupport::Dependencies.autoload_paths += paths
end

setup_autoload 'models', 'actors'