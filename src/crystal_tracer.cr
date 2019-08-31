require "json"
require "stumpy_png"

require "./crystal_tracer/vector3"
require "./crystal_tracer/ray"
require "./crystal_tracer/scene"
require "./crystal_tracer/renderer"
require "./crystal_tracer/camera"

module CrystalTracer
  VERSION = "0.1.0"

  include StumpyPNG

  if ENV["SCENE"].blank? || !File.exists?(ENV["SCENE"])
    puts "Can't open scene file"
    exit 1
  end

  scene = File.open(ENV["SCENE"]) do |file|
    Scene.from_json(file)
  end

  start_time = Time.now

  Renderer.new(scene).render

  end_time = Time.now
  puts "Rendered in #{end_time - start_time}"
end
