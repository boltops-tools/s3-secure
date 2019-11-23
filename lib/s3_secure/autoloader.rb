require "zeitwerk"

module S3Secure
  class Autoloader
    class Inflector < Zeitwerk::Inflector
      def camelize(basename, _abspath)
        map = {
          cli: "CLI",
          force_ssl_only_access: "ForceSSLOnlyAccess",
          version: "VERSION",
        }
        map[basename.to_sym] || super
      end
    end

    class << self
      def setup
        loader = Zeitwerk::Loader.new
        loader.inflector = Inflector.new
        loader.push_dir(File.dirname(__dir__)) # lib
        loader.ignore("#{File.dirname(__dir__)}/s3-secure.rb")
        loader.setup
      end
    end
  end
end
