require "g11n"
require "fast/fast"
require "pry"

def low_level_deconfigurate!
  Fast.dir.delete! :translations

  class << G11n::Translator.instance
    def cleanup
      reset
    end
  end
  
  G11n::Translator.instance.cleanup
end

describe G11n::Translator do
  after :each do  
    low_level_deconfigurate!
  end
  
  describe "#locale=" do
    context "there is no available file for that locale" do
      it "should raise a relevant error" do
        expect { G11n::Translator.instance.locale = :ru
        }.to raise_error G11n::NoTranslationAvailable, 
          "There is no translation file available for the 'ru' locale, check the tranlations source directory configuration"
      end
    end
    
    context "there is a file available for that locale" do
      before { Fast.file.write "translations/en.yaml", "text: Hello" }
      
      it "should set the locale as the given argument" do
        G11n::Translator.instance.locale = :en
        class << G11n::Translator.instance
          def test_me
            @locale.should == :en
          end
        end
        G11n::Translator.instance.test_me
      end
    end
  end
  
  describe "#translations_path=" do
    it "sets the translations path" do
      G11n::Translator.instance.translations_path = "other_path"
      class << G11n::Translator.instance
        def test_me
          @translations_path.should == "other_path"
        end
      end
      G11n::Translator.instance.test_me
    end
  end 
  
  describe "#dictionary_for" do
    context "there is in fact a dictionary for the locale" do
      before do 
        Fast.file.write "translations/en.yaml", { :hello => "Text", :nested => { :is => "good" } }.to_yaml
      end
      
      it "should return the Dictionary object with the information from the YAML file" do
        dictionary = G11n::Translator.instance.dictionary_for :en
        dictionary.should be_a Dictionary
        dictionary.should have_key :hello
      end
    end
  end

  describe "#translate" do
    context "there is a file usable for translation" do
      before do 
        Fast.file.write "translations/en.yaml", { :text => "Hello" }.to_yaml
      end
      
      it "should return the translated string" do
        G11n::Translator.instance.translate.text.should == "Hello"
      end
    end
  end
  
  # PRIVATE methods
  describe "#locale_file_exists_for?" do
    context "the file in deed exists" do
      before { Fast.file.touch "translations/en.yaml" }
      it "should return true" do
        class << G11n::Translator.instance
          def test_me
            locale_file_exists_for?(:en).should == true
          end
        end
        G11n::Translator.instance.test_me
      end
    end
    
    context "there's no such file" do
      it "should return false" do
        class << G11n::Translator.instance
          def test_me
            locale_file_exists_for?(:en).should == false
          end
        end
        G11n::Translator.instance.test_me
      end
    end
  end
end
