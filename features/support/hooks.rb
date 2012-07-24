# The translations/ folder should be removed after use
After "@rollback" do
  Fast.dir.delete! :translations, :i18n

  class << G11n::Translator.instance
    def cleanup
      reset
    end
  end
  
  G11n::Translator.instance.cleanup
end
