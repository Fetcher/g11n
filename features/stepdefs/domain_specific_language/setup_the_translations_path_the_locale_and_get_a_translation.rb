#Scenario: Setup the translations path, the locale and get a translation
#  Given a source file "i18n/uy.yaml" with:
#    """
#    bebida:
#      nacional: Mate
#    """
#  When I send :path "i18n" to the DSL
#  And I send :locale :uy to the DSL
#  And I run "bebida.nacional" on the :t method
#  Then I should see "Mate"

When /^I send :(\w+) "(.+?)" to the configuration DSL$/ do |message, argument|
  o = Object.new
  o.extend G11n::Configuration
  o.send message.to_sym, argument
end 

And /^I send :(\w+) :(\w+) to the configuration DSL$/ do |message, argument|
  o = Object.new
  o.extend G11n::Configuration
  o.send message.to_sym, argument
end

And /^I run "(.*?)" on the :(\w+) method$/ do |argument, message|
  o = Object.new
  o.extend G11n::DSL
  @the_translation = eval "o.#{message}.#{argument}"  
end
