module Pillow
  class Route
    attr_accessor :title, :metas
    def initialize(title = 'Change', metas = {})
      raise ArgumentError, ' title has to be a String.' if !title.instance_of? String
      raise ArgumentError, ' metas has to be a Hash.'   if !metas.instance_of? Hash            
      @title = title
      @metas = metas
    end
    
    def to_s
      text_for_head = ''
      text_for_head << content_tag(:title, title) + "\n"
      @metas.each_pair do |key, value|
        text_for_head << tag(:meta, { :name => key, :content => value }, false)
      end
      text_for_head
    end    
  end
end