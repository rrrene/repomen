module Repomen
  module Repo
    module Handler
      class Base
        include WithDefaultConfig

        attr_reader :config
        attr_reader :path
        attr_reader :url

        def initialize(url, path, _config = default_config)
          @url = url
          @config = Repomen::Config(_config)
          @path = File.join(config.work_dir, path)
        end

        def branch_name
          raise NotImplementedError
        end

        def change_branch(name)
          raise NotImplementedError
        end

        def retrieve
          raise NotImplementedError
        end

        def revision
          raise NotImplementedError
        end
      end
    end
  end
end
