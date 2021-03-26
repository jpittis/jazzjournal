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

timestamps.each do |ts|
  if time = ts["ts"]
    parts = time.split(':')
    ts["ms"] = parts[0].to_i * 60_000 + parts[1].to_i * 1_000
  end
end

File.open("index.html", "w") do |f|
  f.write(renderer.result(params.get_binding))
end

