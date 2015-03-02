class Tailrb
  class Configuration
    DEFAULTS = {
      bytes: 10000
    }

    attr_accessor :bytes, :script, :type
    attr_reader :filter

    def initialize context, config={}
      @context = context
      config = DEFAULTS.merge config
      %i[ type bytes filter script ].each do |key|
        self.send "#{key}=", config[key] if config.key? key
      end
    end

    def filter= filter
      self.script ||= default_script if filter
      @filter = filter
    end

    def tailf_method
      case self.type
      when :tsv then :tailf_tsv
      else :tailf
      end
    end

    def default_script
      serialize = @context.method default_serialize
      proc { |dat| puts serialize.call(dat) }
    end
    def default_serialize
      case self.type
      when :tsv then :to_tsv
      else :to_s
      end
    end
  end
end
