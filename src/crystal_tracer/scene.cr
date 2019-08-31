class Scene
  JSON.mapping(
    width: Int32,
    height: Int32,
    samples: Int32,
    ray_bounces: Int32,
    bg_start: Color,
    bg_end: Color,
    geometry: Array(Sphere)
  )

  def get_color(ray : Ray, depth : Int32)
    return Color.new(0,0,0) if depth == 0

    intersections = get_intersections(ray)

    return get_background_color(ray) unless intersections.any?

    sphere, distance = intersections.min_by { |i| i[1] }

    hit_point = ray.point_at_parameter(distance)
    new_ray = sphere.scatter(hit_point)

    color_probe = get_color(new_ray, depth - 1)

    sphere.get_color(color_probe)
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
