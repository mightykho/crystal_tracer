class Ray
  getter :origin, :direction

  def initialize(origin : Point, direction : Vector3)
    @origin = origin
    @direction = direction
  end

  def point_at_parameter(value : Float64)
    origin + (direction * value)
  end
end

