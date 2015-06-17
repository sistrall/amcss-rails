RSpec::Matchers.define :be_rendered_as do |expected|
  match do |actual|
    render(actual) == render(expected)
  end

  def failure_message
    "\nexpected: #{expected}\n     got: #{render(actual)}\n\n(compared using ==, after rendering SASS with Sass::Engine)\n"
  end

  def failure_message_when_negated
    "\nexpected: value != #{expected}\n     got: #{render(actual)}\n\n(compared using ==, after rendering SASS with Sass::Engine)\n"
  end

  private
    def render(sass)
      Sass::Engine.new(sass, style: :compact, syntax: :scss).render
    end
end