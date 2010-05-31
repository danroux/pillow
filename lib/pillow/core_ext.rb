class Array
  def include_method?(name)
    name = name.to_sym
    !!(find { |item| item.to_sym == name })
  end
end