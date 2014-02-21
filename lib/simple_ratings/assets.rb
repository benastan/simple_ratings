require 'handlebars_assets'
require 'sprockets'
require 'sprockets/browserify'

module SimpleRatings
  class Assets < Sprockets::Environment
    attr_reader :base_path

    def initialize(base_path)
      super
      
      register_postprocessor 'application/javascript', Sprockets::Browserify
      
      @base_path = base_path

      append_path(join('javascripts'))
      
      append_path(join('vendor/jquery-ujs/src'))
      
      append_path(join('stylesheets'))
      
      append_path HandlebarsAssets.path
    end

    def join(*args)
      File.join(*([base_path].concat(args)))
    end
  end
end