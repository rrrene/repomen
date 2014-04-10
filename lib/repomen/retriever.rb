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

    attr_reader :url
    attr_reader :path
    attr_reader :service

    def initialize(url, config = default_config, &block)
      @url = url
      @service = Repo::Service.for(url)
      @handler = @service.handler_class.new(url, repo_dir(service), config)
      @retrieved = @handler.retrieve
      @path = @handler.path
      if block
        block.call(@path)
        discard_repo
      end
    end

    def branch_name
      @handler.branch_name
    end

    # Changes the branch of the retrieved repo.
    # @param name [String] name of the branch
    def change_branch(name, update_branch = false)
      @handler.change_branch(name, update_branch)
      true
    rescue Repomen::HandlerError
      false
    end
    alias :checkout_revision :change_branch

    # Removes the repo from the filesystem
    def discard_repo
      @handler.discard
    end

    # Returns +true+ if the repo was retrieved successfully
    def retrieved?
      @retrieved
    end

    # Returns the revision of the repo.
    def revision
      @handler.revision
    end

    # Returns the tag of the repo.
    def tag
      @handler.tag
    end

    def repo_name
      @service.repo_name
    end

    def service_name
      @service.name
    end

    def user_name
      @service.user_name
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
