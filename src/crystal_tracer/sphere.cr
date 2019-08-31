class Sphere
  JSON.mapping(
    center: Point,
    radius: Float64,
    color: Color,
    roughness: Float64
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

  def scatter(ray : Ray, hit_point : Point)
    normal = normal(hit_point)

    reflect_direction = ray.direction.reflect(normal) * (1 - roughness)
    diffuse_direction = (normal + Vector3.random_unit) * roughness

    result_direction = (reflect_direction + diffuse_direction).normalize

    Ray.new(hit_point, result_direction)
  end

  private def normal(hit_point : Point)
    Vector3.new(center, hit_point).normalize
  end
end
