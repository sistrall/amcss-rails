module Amcss::Rails::ApplicationHelper
  def am(m, content_or_options_with_block = nil, options = nil, escape = true, &block)
    options = case
      when content_or_options_with_block.is_a?(Hash) then content_or_options_with_block
      when options.is_a?(Hash) then options
      else {}
    end

    options_with_amcss_attribute = am_options(m, options)

    klass = "amcss/rails/application_helper/#{Amcss::Rails::Engine.config.amcss.style}_style_am_module_or_trait".classify.constantize

    content = block_given? ? capture(klass.new(self, m), &block) : content_or_options_with_block

    content_tag(:div, content, options_with_amcss_attribute, escape)
  end

  def am_options(m, options = {})
    attribute = Amcss::Html::Attribute.from(m, *(options[:variation] || options[:variations]))

    options
      .except(:variation, :variations)
      .merge(attribute)
  end

  class AmModuleOrTrait < Struct.new(:template, :m)
    def am(*args, &block)
      template.am(*args, &block)
    end
  end

  class AmcssStyleAmModuleOrTrait < AmModuleOrTrait
  end

  class BemStyleAmModuleOrTrait < AmModuleOrTrait
    def am(*args, &block)
      template.am(*module_element(args), &block)
    end

    private
      def module_element(args)
        element = args.shift

        ["#{m}#{Amcss::Rails::Engine.config.amcss.block_element_separator}#{element}"] + args
      end
  end
end
