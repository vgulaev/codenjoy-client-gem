require "codenjoy/client/version"
require "faye/websocket"
require "eventmachine"

module Codenjoy
  module Client
    class Error < StandardError; end
    class Game
      def ws_url(url)
        res = url
        res["board/player/"] = "ws?user="
        res["?code="] = "&code="

        if res.include?("https")
          res["https"] = "wss"
        else
          res["http"] = "ws"
        end
        res
      end

      def play(url, log_level = nil)
        @log_level = log_level
        EM.run {
          ws = Faye::WebSocket::Client.new(ws_url(url))

          ws.on :open do |event|
            p [:open] if 'debug' == @log_level
          end

          ws.on :message do |event|
            yield ws, event.data
          end

          ws.on :close do |event|
            p [:close, event.code, event.reason]  if 'debug' == @log_level
            ws = nil
          end
        }
      end

      def source_path
        __dir__
      end
    end
  end
end
