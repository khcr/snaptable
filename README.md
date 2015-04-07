# Snaptable

A gem that generate HTML tables from your models in order to display them in your admin views. It supports pagination, sorting and searching. It is also possible to customize the tables.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'snaptable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install snaptable

## Usage

### Basic table

In your controller, instanciate a new `Table` with minimum two arguments: the controller itself and the model to use.

```ruby
def index
  @table = Table.new(self, Article)
end
```

Then, in order to enable sorting, call the method `respond` on the table.

```ruby
def index
  @table = Table.new(self, Article)
  @table.respond
end
```

Finally, in your view, generate the table where you wish.

```html
<div>
  <%= @table.present %>
</div>
```

### Options

You can customize the table when you instanciate it. Pass you own collection in the third argument.

```ruby
@articles = Article.last(3)
Table.new(self, Article, @articles)
```

Pass the options in the fourth argument. Here is a list:

* buttons [true]: enable the buttons above the table to add, edit or destroy an element.
* search [false]: enable searching. Add a search field above the table.

```ruby
Table.new(self, Article, nil, { search: true, buttons: false })
```

### Custom class

TODO

### Permissions

if you want to use a permission system, you can enable it in an initializer.

```ruby
# snaptable.rb
Snaptable.use_permission = true
```

When the table fetches the data, it will use `current_permission.records(controller, model, token)`. It is up to you to implement a class and its method that respond to those three arguments.

## Contributing

1. Fork it ( https://github.com/khcr/snaptable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
