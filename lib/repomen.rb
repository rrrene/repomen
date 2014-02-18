require 'repomen/version'

# The Repomen are retrieving repos and can discard them at will.
#
#   url = "git@bitbucket.org:atlassian_tutorial/helloworld.git"
#   Repomen.retrieve(url)
#
# When called with a block, the repo is automatically deleted afterwards
#
#   Repomen.retrieve(url) do |local_path|
#     # repo is cloned in +local_path+
#   end
#   # repo is gone
#
module Repomen
  ROOT = File.join(File.dirname(__FILE__), "..")

  def self.retrieve(url, &block)
    Retriever.new(url, &block)
  end
end

require 'repomen/config'
require 'repomen/retriever'
require 'repomen/repo'
