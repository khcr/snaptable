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

Include the assets:

```css
# application.css
/*
 *= require_self
 *= require_tree .
 *= require snaptable
 */

```

```js
# application.js
//= require_tree .
//= require snaptable
```

## Usage

### Basic table

In your controller, instantiate a new `Table` with minimum two arguments: the controller itself and the model to use.

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

The elements in the table are clickable. Click on an element and use the links above the table to edit or destroy it. If you double-click, you are directly redirect to the edit page. Furthermore, the columns are sortable. Click on a label to sort the data by a column.

### Options

You can customize the table when you instantiate it. Pass you own collection in the third argument.

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

You can also configure the table in the view. The `present` method takes a single named argument to let you add a custom buttons bar. Pass the name of a partial to the parameter `buttons` and the content will be added above the table.

```erb
<div>
  <%= @table.present(buttons: "my_custom_partial") %>
</div>
```
To help you build your custom buttons header, you are provided two helper methods for each of the possible actions (add, show, edit, delete):

`#{action}_button` returns the HTML code to display the button for the desired action, e.g `add_button`.
`#{action}_button?` returns if the user is allowed to see the desired button, e.g. `delete_button?`.

```erb
<div id="custom-buttons">
  <p>This is my custom table header !</p>
  <%= add_button if add_button? %>
<div>
```

Notice that you can customize the buttons header application-wide. With the following options, you decide which buttons are displayed by default.

```ruby
Snaptable.add_button = true
Snaptable.dit_button = true
Snaptable.delete_button = true
Snaptable.show_button = false
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

From that point, you have a working table, but it acts exactly the same than the basic table. You have few possibilities to change the behavior.
If you want to change the table's columns, write a method `attributes` that returns an array of the model's attributes you want to display. It supports associations by allowing you to put a hash.

```ruby
def attributes
  [:title, :content, { user: :name }]
end
```

You can also change how the URL to edit and delete an element is generated. By default, it uses the element's id, but you can specify an other attribute. Write a method `url` that returns an attribute.

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

### Multiple tables

Snaptable supports multiple tables on the same page. However, if you want sorting for your tables to work, then type the following in the controller:

```ruby
def index
  @user_table = UserTable.new(self)
  @group_table = GroupTable.new(self)
  Snaptable.respond_with(self, @user_table, @group_table)
end
```

### Enums

The gem supports enum's type in your model. If it detects a column that is an enum, it will automatically looks for the localized path `#{model.model_name.singular}.#{enum.pluralize}.#{enum_value}`. For example: `member.statuses.active`.

### i18n

To display date & time columns, the gem uses a format named `snaptable`. You can easily override it in your localization file:

```yml
# en.yml

time:
  format:
    snaptable: "%m.d.%y %H:%M"

```

See the [localization files](config/locales) to see all the keys you can override.

### Gotchas

If you're using Postgresql, array types and want to enable searching, then you must create a custom table and specify the fields to search (see above). You must exclude the array columns from the search or it will raise an error.

### Permission

if you want to use the `adeia` gem which provides a permission system:

```ruby
# initializers/snaptable.rb
Snaptable.use_permission = true
```

## Contributing

1. Fork it ( https://github.com/khcr/snaptable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
