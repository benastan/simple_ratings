require 'spec_helper'
require 'fakefs/safe'
require 'fileutils'
require 'pry'

describe SimpleRatings::Assets do
  subject(:assets) { SimpleRatings::Assets.new('.') }

  # around do |example|
  #   FakeFS do
  #     example.run
  #   end
  # end

  before do
    SimpleRatings::Assets.any_instance.stub(:join) do |*args|
      join(*args)
    end
  end

  after do
    FileUtils.rm_rf(join)
  end

  def join(*args)
    File.join(*(['tmp', 'assets']).concat(args))
  end

  def write_javascript(filename, &block)
    full_path = join('javascripts', filename)

    FileUtils.mkdir_p(Pathname.new(full_path).dirname)

    file = File.new(full_path, 'w')

    file.write(yield) 

    file.close
  end

  before do
    write_javascript 'application.js' do
      '//= require foo/index'
    end

    write_javascript 'foo/index.js' do
      <<-JAVASCRIPT
var Something;

Something = require('./something');

module.exports = Something;
JAVASCRIPT
    end

    write_javascript 'foo/package.json' do
      '{"dependencies": {}}'
    end

    write_javascript 'foo/something.js' do
      <<-JAVASCRIPT
module.exports = 'asfdsa';
JAVASCRIPT
    end
  end

  specify do
    assets['application.js'].to_s =~ /asdfsa/
  end
end