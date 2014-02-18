module Repomen
  # This module can be included to provide easy access to the global config
  module WithDefaultConfig
    # @return [Config] the global config
    def default_config
      Repomen.config
    end
  end

  class << self
    # @return [Config] the global config
    def config
      @config ||= Config.new({}, false)
    end

    # @param config [Config,Hash]
    # @return [Config]
    def Config(config)
      if config.is_a?(Hash)
        Config.new(config)
      else
        config
      end
    end
  end

  class Config
    include Repomen::WithDefaultConfig

    attr_writer :work_dir
    attr_accessor :only_last_revision

    # @param options [Hash]
    # @param merge_options [Boolean]
    #   true if the given options should be merged with the global ones
    def initialize(options = {}, merge_options = true)
      options = default_config.to_h.merge(options) if merge_options
      options.each do |name, value|
        send("#{name}=", value)
      end
    end

    def work_dir
      @work_dir || Dir.pwd
    end

    def to_h
      {
        :work_dir => work_dir,
        :only_last_revision => only_last_revision
      }
    end
  end
end
