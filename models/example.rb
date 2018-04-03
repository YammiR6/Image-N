class Example
  attr_accessor :what
  def initialize(what)
    @what = what
  end
  def to_s
    what
  end
end
