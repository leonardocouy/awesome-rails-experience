require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    @image = Docker::Image.build_from_dir('.')

    set :os, family: :alpine
    set :backend, :docker
    set :docker_image, @image.id
    set :docker_container_create_options, { 'Entrypoint' => ['ash'] }
  end

  it "has maintainer" do
    expect(@image.json["Config"]["Labels"]).to match(
      a_hash_including("maintainer" => a_value)
    )
  end

  context "with packages" do
    PACKAGE_LIST = %w(nodejs netcat-openbsd postgresql-dev)

    PACKAGE_LIST.each do |pkg|
      describe package(pkg) do
        it { should be_installed }
      end
    end
  end
end
