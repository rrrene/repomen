require File.expand_path(File.dirname(__FILE__) + '/../../../test_helper')

describe ::Repomen::Repo::Service::BitBucket do
  let(:described_class) { ::Repomen::Repo::Service::BitBucket }

  it "should recognize a Github URL via git" do
    url = "git@bitbucket.org:atlassian_tutorial/helloworld.git"
    service = described_class.new(url)
    assert service.applicable?
    assert_equal "atlassian_tutorial", service.user_name
    assert_equal "helloworld", service.repo_name
  end

  it "should recognize a Github URL via https" do
    url = "https://bitbucket.org/atlassian_tutorial/helloworld.git"
    service = described_class.new(url)
    assert service.applicable?
    assert_equal "atlassian_tutorial", service.user_name
    assert_equal "helloworld", service.repo_name
  end
end
