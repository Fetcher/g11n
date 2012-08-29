module G11n
  # DSL for the configuration of G11n
  module Configuration    
    # Sets the translations path
    def path the_path
      Translator.instance.translations_path = the_path + "/"
    end
    
    # Sets or get the locale
    def locale the_locale = nil
      Translator.instance.locale = the_locale if the_locale
      Translator.instance.locale
    end
  end
end
