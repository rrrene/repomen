module Repomen
  # The Retriever retrieved repos and discards at will.
  #
  #   url = "git@bitbucket.org:atlassian_tutorial/helloworld.git"
  #   Retriever.new(url)
  #
  # When called with a block, the repo is automatically deleted afterwards
  #
  #   Retriever.new(url) do |local_path|
  #     # repo is cloned in +local_path+
  #   end
  #   # repo is gone
  #
  class Retriever
    include WithDefaultConfig

    attr_reader :url, :path

    def initialize(url, config = default_config, &block)
      service = Repo::Service.for(url)
      @handler = service.handler_class.new(url, repo_dir(service), config)
      @handler.retrieve
      @path = @handler.path
      if block
        block.call(@path)
        discard_repo
      end
    end

    # Removes the repo from the filesystem
    def discard_repo
      @handler.discard
    end

    private

    def repo_dir(service)
      parts = [
        service.name, service.user_name, service.repo_name
        ].map(&:to_s)
      File.join(*parts)
    end
  end
end