class Sphere
  JSON.mapping(
    center: Point,
    radius: Float64,
    color: Color
  )

  def intersect(ray : Ray)
    o = ray.origin
    n = ray.direction
    oc = Vector3.new(o, center)

    os = oc.dot(n)

    sc = Math.sqrt(oc.square_len - os * os)

    return nil if os < 0 || sc >= radius

    is = Math.sqrt(radius * radius - sc * sc)

    oi = os - is

    {self, oi}
  end

  def get_color(probe : Color)
    color * probe
  end

  def scatter(hit_point : Point)
    direction = normal(hit_point) + Vector3.random_unit

    Ray.new(hit_point, direction)
  end

  private def normal(hit_point : Point)
    Vector3.new(center, hit_point).normalize
  end
end
