module G11n

  # The Facade so the g11n library gets used by humans!
  module DSL
  
    # Makes the translations. Nice, isn't it? Also, a bonus :translate alias
    def t
      Translator.instance.translate
    end
    
    alias :translate :t
  end
end
