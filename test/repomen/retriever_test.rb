require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe ::Repomen::Retriever do
  let(:described_class) { ::Repomen::Retriever }
  let(:url) { "git@bitbucket.org:atlassian_tutorial/helloworld.git" }
  let(:incorrect_url) { "git@bitbucket.org:atlassian_tutorial/helloworld123.git" }

  it "should retrieve the repo" do
    retriever = described_class.new(url)
    assert retriever.retrieved?
    assert File.exist?(retriever.path)

    retriever.discard_repo
    assert !File.exist?(retriever.path)
  end

  it "should retrieve the repo" do
    retriever = described_class.new(incorrect_url)
    refute retriever.retrieved?
  end

  it "should retrieve the repo, yield to block and discard the repo" do
    @path = nil
    described_class.new(url) do |path|
      @path = path
      assert File.exist?(@path)
    end
    assert !File.exist?(@path)
  end
end
