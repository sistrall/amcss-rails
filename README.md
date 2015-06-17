# Amcss::Rails

amcss-rails make [amcss](https://github.com/sistrall/amcss) in Rails.

(Don't know amcss? Take a look at the [README](https://github.com/sistrall/amcss/blob/master/README.md))

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amcss-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install amcss-rails

## Usage

amcss-rails allows you to use helper in your views like this:

```erb
<%= am('Calendar', variation: 'flat') do %>
  <p>Hi, I'm a calendar</p>
<% end %>
```

What you'll get is a `div` with AMCSS attribute:

```html
<div am-Calendar="flat">
  <p>Hi, I'm a calendar</p>
</div>
```

It seems nothing, but the interesting part comes when you try to nest blocks and add a little bit of configuration. Take a look.

Create 2 initializer files:

```ruby
# In config/initializers/amcss.rb
Amcss.configure do |configuration|
  configuration.prefix = :data
end
```

```ruby
# In config/initializers/amcss-rails.rb
Amcss::Rails::Engine.configure do |engine|
  engine.config.amcss.style = :bem
  engine.config.amcss.block_element_separator = '__'
end
```

Than write this code in your template:

```erb
<%= am(:calendar, variation: 'flat') do |calendar| %>
  <%= calendar.am(:header, variation: 'padded') do %>
    Header
  <% end %>
  <%= calendar.am(:body) do %>
    Body
  <% end %>
<% end %>
```

This is what you get:

```html
<div data-am-calendar="flat">
  <div data-am-calendar__header="padded"></div>
  <div data-am-calendar__body=""></div>
</div>
```

Even easier to read if you are a HAML fan:

```haml
= am(:calendar, variation: 'flat') do |calendar|
  = calendar.am(:header, variation: 'padded') do
    Header
  = calendar.am(:body) do
    Body
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/amcss-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
