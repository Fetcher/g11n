module G11n
  # Manages the configuration of the G11n library
  class Translator
    include Singleton
    
    def initialize
      reset
    end
    
    # Sets the locale. Fails if the locale matches no available file
    def locale= the_locale
      unless locale_file_exists_for? the_locale
        raise NoTranslationAvailable, "There is no translation file available for the '#{the_locale}' locale, check the tranlations source directory configuration"
      end      
      @locale = the_locale
    end
    
    # Sets the path where translations will be looked for
    def translations_path= the_path
      @translations_path = the_path
    end
   
    # Forwards the method call to the right "dictionary" (a SymbolTable object)
    # http://mjijackson.com/2010/04/config-revisited
    # What it truely does the #translate method is to retrieve the right SymbolTable object from the 
    # dictionary
    def translate
      dictionary_for @locale
    end
    
    # Looks and returns the right dictionary for the given locale
    def dictionary_for the_locale
      return @dictionaries[the_locale] if @dictionaries.has_key? the_locale # In case is already loaded
      if File.exists? "#{@translations_path}#{the_locale}.yaml" 
        @dictionaries[the_locale] = Dictionary.new YAML.load_file "#{@translations_path}#{the_locale}.yaml"
      elsif File.exists? "#{@translations_path}#{the_locale}.yml"
        @dictionaries[the_locale] = Dictionary.new YAML.load_file "#{@translations_path}#{the_locale}.yml"
      else
        raise NoTranslationAvailable, "There is no translation file available for the '#{the_locale}' locale, check the tranlations source directory configuration"
      end
    end
    
    private
      def locale_file_exists_for? the_locale
        File.exists?("#{@translations_path}#{the_locale}.yaml") || File.exists?("#{@translations_path}#{the_locale}.yml")
      end
      
      def reset
        @translations_path = "translations/"
        @dictionaries = {}
        @locale = :en
      end
  end
end
