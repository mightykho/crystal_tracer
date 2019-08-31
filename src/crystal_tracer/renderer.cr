class Renderer
  private getter :scene, :canvas, :camera

  def initialize(scene : Scene)
    @scene = scene
    @canvas = Canvas.new(scene.width, scene.height)
    @camera = Camera.new(scene.width, scene.height)
  end

  def render
    canvas.map! do |_, x, y|
      get_color(x, scene.height - y).to_rgba
    end

    StumpyPNG.write(canvas, "output.png")
  end

  private def get_color(x : Int32, y : Int32)
    color = Color.new(0, 0, 0)

    (0...scene.samples).each do |_sample|
      ray = camera.build_ray_through(x, y)
      color += scene.get_color(ray)
    end

    color / scene.samples.to_f
  end
end
