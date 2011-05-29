module ApplicationHelper

  def hidden_div_if(b_condition, attrs = {}, &block)
    if b_condition
      attrs['style'] = 'display: none'
    end
    content_tag(:div, attrs, &block)
  end

end
