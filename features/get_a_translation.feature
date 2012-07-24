Feature: Get a translation
  In order to get a translation of an identifier
  As a developer of an internationalized app
  I want to have a simple syntax

@rollback
Scenario: Simple example and simple translation
  Given a source file "translations/en.yaml" with:
    """
    hello: Hello World!
    """
  When I have the locale setted as "en"
  And I write "hello" in the translation engine
  Then I should see "Hello World!"
  
@rollback
Scenario: Not so simple, more interesting case
  Given a source file "translations/ru.yml" with:
    """
    home:
      country: Российская Федерация
    """
  When I have the locale setted as "ru"
  And I write "home.country" in the translation engine
  Then I should see "Российская Федерация"

@rollback
Scenario: With several languages and changing language on the fly
  Given a source file "translations/es-ar.yaml" with:
    """
    home:
      country:
        legal_name: República Argentina
    """
  And a source file "translations/ja.yml" with:
    """
    home:
      country:
        legal_name: 日本国
    """
  When I have the locale setted as "es-ar"
  And I write "home.country.legal_name" in the translation engine
  Then I should see "República Argentina"
  When I have the locale setted as "ja"
  And I write "home.country.legal_name" in the translation engine
  Then I should see "日本国"

@rollback
Scenario: Locale left default
  Given a source file "translations/en.yaml" with:
    """
    comes:
      from: USA
    """
  When I write "comes.from" in the translation engine
  Then I should see "USA"
