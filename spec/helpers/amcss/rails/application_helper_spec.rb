require 'spec_helper'

# = am('author-experience') do |m|
#   = m.am('header') do
#     Best practice of the author

# = am('counter', mod: 'check-ins') do |n|
#   = n.am('icon') do
#     Content

# = am('best-practice-card', for: %w{am js}) do
#   Content

RSpec.describe Amcss::Rails::ApplicationHelper, type: :helper do
  describe "#am" do
    it 'supports symbols' do
      expect(helper.am(:Calendar, 'Monthly calendar', variations: %i{big flat}))
        .to eq '<div am-Calendar="big flat">Monthly calendar</div>'
    end

    it 'supports strings' do
      expect(helper.am('Calendar', 'Monthly calendar', variation: 'big'))
        .to eq '<div am-Calendar="big">Monthly calendar</div>'
    end

    it 'supports passing options' do
      expect(helper.am('Calendar', 'Monthly calendar', variation: 'big', class: 'bootstrap-class', style: "You know you should not inline style!"))
        .to match_html <<-HTML
          <div class="bootstrap-class" style="You know you should not inline style!" am-Calendar="big">
            Monthly calendar
          </div>
        HTML
      end

    context "without blocks" do
      it "returns a div tag" do
        expect(helper.am('Calendar', 'Monthly calendar'))
          .to eq '<div am-Calendar="">Monthly calendar</div>'

        expect(helper.am('Calendar', 'Monthly calendar', variation: 'big'))
          .to eq '<div am-Calendar="big">Monthly calendar</div>'

        expect(helper.am('Calendar', 'Monthly calendar', variations: 'small rounded'))
          .to eq '<div am-Calendar="small rounded">Monthly calendar</div>'

        expect(helper.am('Calendar', 'Monthly calendar', variations: %w{small rounded}))
          .to eq '<div am-Calendar="small rounded">Monthly calendar</div>'
      end
    end

    context "with blocks" do
      it "returns a div tag" do
        expect(helper.am('Calendar') {})
          .to eq '<div am-Calendar=""></div>'

        expect(helper.am('Calendar', variation: 'big') {})
          .to eq '<div am-Calendar="big"></div>'

        expect(helper.am('Calendar', variations: 'small rounded') {})
          .to eq '<div am-Calendar="small rounded"></div>'

        expect(helper.am('Calendar', variations: %w{small rounded}) {})
          .to eq '<div am-Calendar="small rounded"></div>'
      end
    end

    context "nested usage" do
      it "returns a div within a div" do
        expect(helper.am('Calendar') { |m|
          m.am('CalendarHeader') {}
        }).to match_html <<-HTML
          <div am-Calendar="">
            <div am-CalendarHeader=""></div>
          </div>
        HTML
      end

      it "returns nested divs" do
        expect(helper.am('Calendar', variation: 'flat') { |m|
          m.am('CalendarHeader', '', variation: 'padded') + m.am('CalendarBody', '')
        }).to match_html <<-HTML
          <div am-Calendar="flat">
            <div am-CalendarHeader="padded"></div>
            <div am-CalendarBody=""></div>
          </div>
        HTML
      end
    end

    context "with gem configuration for data-* attributes" do
      before(:each) do
        Amcss.configure do |configuration|
          configuration.prefix = :data
        end
      end

      it 'return HTML with data-am-* attributes' do
        expect(helper.am(:Calendar, 'Monthly calendar', variation: %i{big flat}))
          .to eq '<div data-am-Calendar="big flat">Monthly calendar</div>'
      end
    end

    context "with gem configuration for BEM style" do
      before(:each) do
        Amcss::Rails::Engine.configure do
          config.amcss.style = :bem
        end
      end

      it 'returns HTML with attribute in BEM style (am-block--element)' do
        expect(helper.am(:calendar, variation: 'flat') { |calendar|
          calendar.am(:header, '', variation: 'padded') + calendar.am(:body, '')
        }).to match_html <<-HTML
          <div am-calendar="flat">
            <div am-calendar__header="padded"></div>
            <div am-calendar__body=""></div>
          </div>
        HTML
      end
    end

    context "with gem configuration for data-* attributes and BEM style" do
      before(:each) do
        Amcss.configure do |configuration|
          configuration.prefix = :data
        end

        Amcss::Rails::Engine.configure do
          config.amcss.style = :bem
        end
      end

      it 'return HTML with data-am-* attributes in BEM style' do
        expect(helper.am(:calendar, variation: 'flat') { |calendar|
          calendar.am(:header, '', variation: 'padded') + calendar.am(:body, '')
        }).to match_html <<-HTML
          <div data-am-calendar="flat">
            <div data-am-calendar__header="padded"></div>
            <div data-am-calendar__body=""></div>
          </div>
        HTML
      end
    end
  end
end