require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe ::Repomen::Retriever do
  let(:described_class) { ::Repomen::Retriever }
  let(:url) { "git@bitbucket.org:atlassian_tutorial/helloworld.git" }

  it "should retrieve the repo" do
    retriever = described_class.new(url)
    assert File.exists?(retriever.path)

    retriever.discard_repo
    assert !File.exists?(retriever.path)
  end

  it "should retrieve the repo, yield to block and discard the repo" do
    @path = nil
    described_class.new(url) do |path|
      @path = path
      assert File.exists?(@path)
    end
    assert !File.exists?(@path)
  end
end
