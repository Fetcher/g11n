module G11n
  # DSL for the configuration of G11n
  module Configuration    
    # Sets the translations path
    def path the_path
      Translator.instance.translations_path = the_path + "/"
    end
    
    # Sets the locale
    def locale the_locale
      Translator.instance.locale = the_locale
    end
  end
end
