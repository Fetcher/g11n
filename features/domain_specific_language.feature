Feature: Domain Specific Language
  In order to use the g11n engine easily
  As a developer
  I want to have a DSL in a Façade object
  
@rollback
Scenario: Setup the translations path, the locale and get a translation
  Given a source file "i18n/uy.yaml" with:
    """
    bebida:
      nacional: Mate
    """
  When I send :path "i18n" to the configuration DSL
  And I send :locale :uy to the configuration DSL
  And I run "bebida.nacional" on the :t method
  Then I should see "Mate"
