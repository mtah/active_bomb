module ActiveBomb

  class Base < ActiveResource::Base
    self.site = 'http://api.giantbomb.com'

    class << self
      def api_key
        if defined?(@api_key)
          @api_key
        elsif superclass.respond_to?(:api_key) && superclass.api_key
          superclass.api_key.dup.freeze
        else
          raise 'Missing API key'
        end
      end
      
      def api_key=(key)
        @api_key = key
      end
      
      def element_path(id, prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{element_name}/#{URI.escape id.to_s}/#{query_string(query_options)}"
      end
      
      def collection_path(prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{collection_name}/#{query_string(query_options)}"
      end

      private
      def query_string(options)
        options ? options.dup : {}
        options[:api_key] = api_key
        options[:format] = format.extension
        super(options)
      end
    end

    def save
      read_only_error
    end
      
    def destroy
      read_only_error
    end
    
    private
    def read_only_error
      raise 'The Giant Bomb API is read-only'
    end
  end
end
