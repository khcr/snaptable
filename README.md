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

The gem requires also jQuery.

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

The elements in the table are clickable. Click on an element and use the links above the table to edit or destroy it. If you double-click, you are directly redirect to the edit page.

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

If you need more control on the displayed fields or on the search, you can easily create your own table.
Create a directory `app/tables`. Then create a file `my_model_table.rb`. Inside declare a class `MyModelTable` that inherits from `BaseTable`.
You must necessarily write a method called `model` that returns the model to use for your table.

```ruby
# article_table.rb
class ArticleTable < BaseTable

  def model
    Article
  end

end
```

From that point, you have a working table, but it acts exactly the same than the basic table. You have few possibilites to change the behavior.
If you want to change the table's columns, write a method `attributes` that return an array of the model's attributes you want to display. It supports associations by allowing you to put a hash.

```ruby
def attributes
  [:title, :content, { user: :name }]
end
```

You can also change how the URL to edit and delete an element is generated. By default it uses the element's id, but you can specify an other attribute. Write a method `url` that returns the attribute.

```ruby
def url
  :slug
end
```

By default, the search is done on the string fields of the model. If you want to search on the associations, create a module `Search` inside the class. Then declare a method `self.fields` that returns a hash and `self.associations` that returns an array. Be careful, the search is only possible on string fields.

```ruby
class ArticleTable < BaseTable

  def model
    Article
  end

  def attributes
    [:title, :content, { user: :name }]
  end

  def url
    :slug
  end

  module Search

    def self.associations
      [:user, :category]
    end

    def self.fields
      { articles: [:title, :content], user: [:name, :email], category: [:name] }
    end

  end
```

### Permission

if you want to use a permission system, you can enable it in an initializer.

```ruby
# initializers/snaptable.rb
Snaptable.use_permission = true
```

When the table fetches the data, it will use `current_permission.records(controller, model, token)`. It is up to you to implement the class and its method that respond to those three arguments.

## Contributing

1. Fork it ( https://github.com/khcr/snaptable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
