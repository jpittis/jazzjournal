require "erb"
require "yaml"

class Params
  def initialize(timestamps)
    @timestamps = timestamps
  end

  def get_binding
    binding
  end
end

timestamps = YAML.load_file("timestamps.yaml")
renderer   = ERB.new(File.read("index.html.erb"))
params     = Params.new(timestamps)

File.open("index.html", "w") do |f|
  f.write(renderer.result(params.get_binding))
end

