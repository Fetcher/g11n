# G11n is Globalization

Globalization (g11n) is a Ruby Gem for easy language file handling aimed at internationalized projects.

The developers of g11n are well aware of the existence of both i18n and r18n Ruby Gems, but wanted a new approach (specially in terms of simplicity) and this is the answer.

## Usage

G11n assumes you will have a series of language files written in YAML in an accessible folder to your project, named after each language's locale and followed by the YAML extension. Both `.yaml` and `.yml` extensions are recognized.

The default path for that folder is `translations/`. So, for example, if you have a file named `translations/it.yaml` that reads as...

    # ./translations/it.yaml
    home:
      title: La pasta di la nonna
      menu:
        preparation: Comme farla
        eating: Comme si mangia
        wine: Con che si accompagna

... you can, in your project, insert the following code and get the internationalized strings:

    # .script.rb
    require "g11n"
    
    G11n.locale :it                             # Configures G11n to use italian. Default is "en"
    
    G11n.t.home.title                           # => "La pasta di la nonna"
    G11n.t.home.menu.wine                       # => "Con che si accompagna"
    
## Installation

    $ gem install g11n

### Or when using Bundler

Add this line to your application's Gemfile:

    gem 'g11n'

And then execute:

    $ bundle

## Configuring

Configuration is straight forward. You are using another directory for your language files? Just `G11n.path "your/path"`. You want to change the locale? `G11n.locale :yours`.

    # ./translations/ru.yml
    home:
      land: Российская Федерация
    
    require "g11n"
    
    G11n.path "i18ns"
    G11n.locale :ru
    
    G11n.t.home.land                           # => "Российская Федерация"

Also, the `G11n::DSL` module can be included in any object of class you want to use the `#t` method more confortably.

> **Note**: g11n is planned to soon be made a Sinatra extension

## Testing

Cucumber features and RSpec specs are provided to check functionality.

An exception is the G11n::Dictionary class, which is just a subclass of SymbolTable that recursively converts all hashes passed as argument to the initializer into Dictionaries. This is really handy.

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
