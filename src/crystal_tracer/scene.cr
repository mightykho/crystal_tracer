class Scene
  JSON.mapping(
    width: Int32,
    height: Int32,
    samples: Int32,
    bg_start: Color,
    bg_end: Color,
    geometry: Array(Sphere)
  )

  def get_color(ray : Ray)
    sphere = geometry.find do |s|
      s.intersect(ray)
    end

    return get_background_color(ray) unless sphere

    sphere.color
  end

  private def get_background_color(ray : Ray)
    t = 0.5 * ray.direction[1] + 1

    Vector3.lerp(bg_start, bg_end, t)
  end
end
