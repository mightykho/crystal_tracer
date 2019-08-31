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

    sc < radius
  end
end
