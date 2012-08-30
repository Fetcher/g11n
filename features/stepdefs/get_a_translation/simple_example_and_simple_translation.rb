#Scenario: Simple example and simple translation
#  Given a source file "translations/en.yaml" with:
#    """
#    hello: Hello World!
#    """
#  When I have the locale setted as "en"
#  And I write "hello" in the translation engine
#  Then I should see "Hello World!"

Given /^a source file "(.*?)" with:$/ do |file, content|
  Fast.file.write file, content
end

When /^I have the locale setted as "(.*?)"$/ do |locale|
  G11n::Translator.instance.locale = locale.to_sym
end

And /^I write "(.*?)" in the translation engine$/ do |identifier|
  @result = eval "G11n::Translator.instance.translate.#{identifier}"
end

Then /^I should see "(.*?)"$/ do |text|
  @result.should == text
end
