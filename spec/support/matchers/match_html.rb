RSpec::Matchers.define :match_html do |expected|
  match do |actual|
    actual == squished_expected
  end

  def failure_message
    "\nexpected: #{squished_expected}\n     got: #{actual}\n\n(compared using ==, after removing /\\n\\s+/ and squishing HTML)\n"
  end

  def failure_message_when_negated
    "\nexpected: value != #{squished_expected}\n     got: #{actual}\n\n(compared using ==, after removing /\\n\\s+/ and squishing HTML)\n"
  end

  private
    def squished_expected
      expected.gsub(/\n\s+/, '').squish
    end
end