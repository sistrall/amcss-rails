module Amcss::Rails::Helper
  def am(modüle, *variations_or_traits, &block)
    content_tag(:div, {}, &block)
  end
end
