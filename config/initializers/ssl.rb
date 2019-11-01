# /config/initializers/ssl.rb

require 'open-uri'
require 'net/https'

module Net
  class HTTP
    alias_method :original_use_ssl=, :use_ssl=

    def use_ssl=(flag)
      store = OpenSSL::X509::Store.new
      store.set_default_paths

      store.add_cert(OpenSSL::X509::Certificate.new(File.read("#{Rails.root}/config/ssl/server.crt")))
      #store.add_cert(OpenSSL::X509::Certificate.new(File.read("#{Rails.root}/config/ssl/intermediate.crt")))

      self.cert_store = store

      self.verify_mode = OpenSSL::SSL::VERIFY_PEER
      self.original_use_ssl = flag
    end
  end
end
