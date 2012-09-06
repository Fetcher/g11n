# G11n is Globalization
[![Build Status](https://secure.travis-ci.org/Fetcher/g11n.png)](http://travis-ci.org/Fetcher/g11n) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/Fetcher/g11n)

Globalization (g11n) is a Ruby Gem for easy language file handling aimed at internationalized projects.

The developers of g11n are well aware of the existence of both i18n and r18n Ruby Gems, but wanted a new approach (specially in terms of simplicity) and this is the answer.

## Usage

G11n assumes you will have a series of language files written in YAML in an accessible folder to your project, named after each language's locale and followed by the YAML extension. Both `.yaml` and `.yml` extensions are recognized.

The default path for that folder is `translations/`. So, for example, if you have a file named `translations/it.yaml` that reads as...

```yaml
# ./translations/it.yaml
home:
  title: La pasta della nonna
  menu:
    preparation: Comme farla
    eating: Comme si mangia
    wine: Con che si accompagna
```

... you can, in your project, insert the following code and get the internationalized strings:

```ruby
# .script.rb
require "g11n"

G11n.locale :it                             # Configures G11n to use italian. Default is "en"
G11n.locale                                 # => :it

G11n.t.home.title                           # => "La pasta della nonna"
G11n.t.home.menu.wine                       # => "Con che si accompagna"
```
    
## Installation

    gem install g11n

### Or when using Bundler

Add this line to your application's Gemfile:

    gem 'g11n'

And then execute:

    bundle install

## Configuring

Configuration is straight forward. You are using another directory for your language files? Just `G11n.path "your/path"`. You want to change the locale? `G11n.locale :yours`.

For example, a translations file in a non-standard folder:

```yaml
# ./i18ns/ru.yml
home:
  land: Российская Федерация
```

And a script in the base folder:

```ruby
# ./script.rb
require "g11n"

G11n.path "i18ns"
G11n.locale :ru

G11n.t.home.land                           # => "Российская Федерация"
```

Also, the `G11n::DSL` module can be included in any object of class you want to use the `#t` method more confortably.

## Use it in Sinatra
The G11n DSL (the `#t` and `#translate` methods) are available as a module unimaginatively called `G11n::DSL`. You can of course include it into your helpers as easy as:

```ruby
# .app.rb
require 'sinatra'
require 'g11n'

helpers G11n::DSL

G11n.locale :es

get '/' do
  t.welcome                             # => "¡Bienvenido, amigo!" 
                                        # as described in es.yaml
end
```

```yaml
# .translations/es.yaml
welcome: ¡Bienvenido, amigo!
```

It works in modular style too.

## Future
- Change the Configuration DSL so #translations_path or #translations or something like that is used to set the path, so that the full DSL can be included as helper in Sinatra. Deprecate Configuration#path
- Add support to reload. Store "last read" date and reload the file if changed. Disable in production mode (good reason to add Sinatra Extension: disabling in production and autoincluding the DSL)
- Document usage of Ruby's `String` interpolation in G11n
- Add support for named string interpolation using the same `%` operator. Add an alias to the `%` interpolation operation, some method name easier to remember (even if its longer)
- Add support for string arguments to get further Rails I18n compatibility
- Add flag to activate Rails I18n compatibility mode
- Add support for locale as argument of Translator#translate

### Date, number, ... helpers
Rails provide a nice functionality for number and date helpers that, since relays on words, ends up needing internationalizations. G11n is compatible with Rails I18n approach, that uses YAML, but not entirely since G11n uses different files for each locale. 

In the case that a helper library that doesn't depend on Rails with those methods its found in the wild, G11n should be someway be made compatible.

### Package Managers! Dictionaries!
Related to the helpers above... well, is known that many words need to be translated only once. A package manager for G11n will do the trick of getting a lot of translations easier.

Of course, since one cannot know the handler for certain word in every case, G11n should also implement a Chain of Responsibility to discover standard handlers if none is defined.

## Testing

Cucumber features and RSpec specs are provided to check functionality.

## License

Copyright (C) 2012 Fetcher

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
