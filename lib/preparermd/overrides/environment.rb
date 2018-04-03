require 'json'
require 'uri'
require 'pathname'

require 'faraday'
require 'sprockets'
require 'jekyll/assets/env'

# Module to be mixed in to each uploaded Asset to ensure that the correct URLs are generated.
#
module PreparerMD
  module AssetPatch
    attr_accessor :asset_render_url
  end
end

# Custom Index subclass that uploads each built asset to the content service as it is discovered.
#
class Index < Sprockets::CachedEnvironment
  def build_asset(path, pathname, options)
    super.tap do |asset|
      dest = File.join(PreparerMD.config.asset_dir, asset.logical_path)

      if PreparerMD.config.verbose
        print "Copying content asset: [#{asset.pathname}] .. "
        $stdout.flush
      end

      FileUtils.mkdir_p File.dirname(dest)
      FileUtils.cp asset.pathname.to_s, dest

      local_path = Pathname.new(asset.logical_path).cleanpath.to_s

      asset.extend PreparerMD::AssetPatch
      asset.asset_render_url = "__deconst-asset:#{URI.escape local_path, '%_&"<>'}__"

      puts "ok" if PreparerMD.config.verbose
    end
  end
end

# Custom Sprockets Environment subclass that uses our injected Index subclass.
#
class Env < Jekyll::Assets::Env
  def index
    Index.new(self)
  end
end

# Monkey-patch the Jekyll Assets plugin AssetPath class to use the #asset_render_url
#
module Jekyll
  module Assets

    class Context
      alias_method :orig_to_s, :asset_path
      def asset_path
        @asset.respond_to?(:asset_render_url) ? @asset.asset_render_url : orig_to_s
      end
    end

  end
end
