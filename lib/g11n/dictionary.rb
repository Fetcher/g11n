# Stupid but really useful class:
# Inherits from SymbolTable (https://github.com/mjijackson/symboltable), but when it is initialized
# it simply... well, recursively converts all Hashes into dictionaries
module G11n
  class Dictionary < SymbolTable
    
    def initialize *args
      super *args
      _symbolize!
    end
    
    private
      def _symbolize!
        each_key do |key|
          if self[key].instance_of? Hash
            self[key] = Dictionary.new self[key]
          end
        end
      end
  end
end
