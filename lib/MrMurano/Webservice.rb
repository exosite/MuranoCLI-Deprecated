require 'uri'
require 'MrMurano/Config'
require 'MrMurano/http'
require 'MrMurano/verbosing'
require 'MrMurano/SyncUpDown'

module MrMurano

  ## The details of talking to the Webservice service.
  module Webservice
    class Base
      def initialize
        @pid = $cfg['application.id']
        raise MrMurano::ConfigError.new("No application id!") if @pid.nil?
        @uriparts = [:solution, @pid]
        @itemkey = :id
        @locationbase = $cfg['location.base']
        @location = nil
      end

      include Http
      include Verbose

      ## Generate an endpoint in Murano
      # Uses the uriparts and path
      # @param path String: any additional parts for the URI
      # @return URI: The full URI for this endpoint.
      def endPoint(path='')
        parts = ['https:/', $cfg['net.host'], 'api:1'] + @uriparts
        s = parts.map{|v| v.to_s}.join('/')
        URI(s + path.to_s)
      end
      # …

      include SyncUpDown
    end
  end
end

#  vim: set ai et sw=2 ts=2 :

