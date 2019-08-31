require "stumpy_core"
include StumpyCore

alias Color = Vector3
alias Point = Vector3

struct Vector3
  def self.new(origin : Point, target : Point)
    target - origin
  end

  def self.random_unit
    Vector3.new(
      2.0 * Random.rand - 1,
      2.0 * Random.rand - 1,
      2.0 * Random.rand - 1
    ).normalize
  end

  def self.lerp(s : Vector3, e : Vector3, t : Float64)
    s + (e - s) * t
  end

  def initialize(a : Float64, b : Float64, c : Float64)
    @data = [a, b, c]
  end

  def initialize(json : JSON::PullParser)
    data = [] of Float64

    json.read_array do
      data.push Float64.new(json)
    end

    raise ArgumentError.new if data.size != 3
    @data = data
  end

  def [](i : UInt32)
    @data[i]
  end

  def *(v : Vector3)
    Vector3.new(self[0] * v[0], self[1] * v[1], self[2] * v[2])
  end

  def *(value : Float64)
    Vector3.new(self[0] * value, self[1] * value, self[2] * value)
  end

  def /(v : Vector3)
    Vector3.new(self[0] / v[0], self[1] / v[1], self[2] / v[2])
  end

  def /(value : Float64)
    Vector3.new(self[0] / value, self[1] / value, self[2] / value)
  end

  def +(v : Vector3)
    Vector3.new(self[0] + v[0], self[1] + v[1], self[2] + v[2])
  end

  def -(v : Vector3)
    Vector3.new(self[0] - v[0], self[1] - v[1], self[2] - v[2])
  end

  def clamp
    Vector3.new(
      Math.min(self[0], 1.0),
      Math.min(self[1], 1.0),
      Math.min(self[2], 1.0),
    )
  end

  def normalize
    self * (1 / len)
  end

  def len
    Math.sqrt(square_len)
  end

  def dot(v : Vector3)
    self[0] * v[0] + self[1] * v[1] + self[2] * v[2]
  end

  def square_len
    self[0] * self[0] + self[1] * self[1] + self[2] * self[2]
  end

  def to_rgba
    v = self * 255
    RGBA.from_rgb_n(v[0].to_i, v[1].to_i, v[2].to_i, 8)
  end

  def reflect(normal : Vector3)
    # r = d - 2(d . n) * n

    self - normal * (2 * self.dot(normal))
  end
end

