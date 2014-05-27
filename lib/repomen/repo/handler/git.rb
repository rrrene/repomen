require 'fileutils'

module Repomen
  HandlerError = Class.new(RuntimeError)

  module Repo
    module Handler
      # Handler for git repositories
      #
      # @todo Uses git's CLI, since Rugged is not playing nice GitHub
      #   Why is that?
      class Git < Base
        def branch_name
          branch = nil
          in_dir do
            branch = git(:'rev-parse', '--abbrev-ref', 'HEAD')
          end
          branch
        end

        def change_branch(name, update_branch = false)
          in_dir do
            output = git(:checkout, name, '--quiet')
            unless $?.success?
              raise HandlerError.new("checkout failed: #{name.inspect}")
            end
            pull if update_branch
          end
        end
        alias :checkout_revision :change_branch

        # Removes the repo from the filesystem
        # @return [void]
        def discard
          FileUtils.rm_rf(path) if repo_exists?
        end

        # Retrieves the repo from +@url+
        # @return [void]
        def retrieve(branch_name = "master")
          if repo_exists?
            change_branch(branch_name)
            update_repo
          else
            clone_repo
            change_branch(branch_name) if $?.success?
          end
          $?.success?
        end

        def revision_info
          @revision_info ||= parse_revision_info(git_show)
        end

        def tag
          output = nil
          in_dir do
            output = git(:describe, '--tags --exact-match', 'HEAD')
          end
          output
        end

        private

        def git_show
          format = [
            'name: %an',
            'email: %ae',
            'date: %cd',
            'commit: %H',
            'message: %s',
          ].join('%n')
          output = nil
          in_dir do
            output = git(:show, '--format="'+format+'"')
          end
          output
        end

        def git(*args)
          `git #{args.join(' ')}`.chomp
        end

        def in_dir(dir = @path, &block)
          Dir.chdir(dir, &block)
        end

        def clone_repo
          FileUtils.mkdir_p path
          git(:clone, url, path, '--quiet')
        end

        def git_options
          options = %w(--quiet)
          if config.only_last_revision
            options << '--depth=1'
          end
          options.join(' ')
        end

        def parse_revision_info(text)
          info = {}
          text.lines.each do |str|
            break if str.strip.empty?
            list = str.partition(': ')
            info[list.first] = list.last
              .encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
              .gsub(/\n$/, '')
          end
          info
        end

        def update_repo
          pull
        end

        def pull
          in_dir do
            git(:pull, '--quiet')
          end
        end

        def repo_exists?
          File.exist?( File.join(path, ".git") )
        end
      end
    end
  end
end
