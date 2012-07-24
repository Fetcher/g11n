# Core
require "singleton"

# Third-party
require "symboltable"

# Local
require "g11n/version"
require "g11n/translator"
require "g11n/dictionary"
require "g11n/exceptions"
require "g11n/dsl"
require "g11n/configuration"

module G11n
  class << self
    include DSL
    include Configuration
  end
end
