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
    intersections = get_intersections(ray)

    return get_background_color(ray) unless intersections.any?

    intersection = intersections.min_by { |i| i[1] }

    intersection[0].color
  end

  private def get_intersections(ray : Ray)
    geometry.map do |sphere|
      sphere.intersect(ray)
    end.compact
  end

  private def get_background_color(ray : Ray)
    t = 0.5 * ray.direction[1] + 1

    Vector3.lerp(bg_start, bg_end, t)
  end
end
