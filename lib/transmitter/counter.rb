class Counter
  include Singleton

  def initialize
    @current = 0
  end

  def next
    @current += 1
  end

  def reset
    @current = 0
  end
end
