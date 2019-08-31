class Camera
  private getter :screen_width, :screen_height

  WIDTH_UNITS = 4.0_f64
  ORIGIN = Point.new(0,0,0)

  def initialize(screen_width : Int32, screen_height : Int32)
    @screen_width = screen_width
    @screen_height = screen_height
  end

  def build_ray_through(x, y)
    u = units_per_pixel * (x + Random.rand)
    v = units_per_pixel * (y + Random.rand)

    target = screen_bottom_left + Point.new(u, v, 0)
    direction = Vector3.new(ORIGIN, target).normalize

    Ray.new(ORIGIN, direction)
  end

  private def units_per_pixel
    @units_per_pixel ||= Float64.new(WIDTH_UNITS / screen_width)
  end

  private def screen_bottom_left
    @screen_bottom_left ||= Point.new(-WIDTH_UNITS / 2, -height_units / 2, -1)
  end

  private def height_units
    @height_units ||= Float64.new(WIDTH_UNITS * screen_height / screen_width)
  end
end
