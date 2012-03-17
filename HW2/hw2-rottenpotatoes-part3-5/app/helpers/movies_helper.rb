module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def is_sort_target(header, value)
    return '' if value.nil?
    class_name = value.to_s + '_header'
    (header == class_name) ? 'hilite' : ''
  end
end
