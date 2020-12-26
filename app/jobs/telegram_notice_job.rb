# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

class TelegramNoticeJob < ApplicationJob
  WEBHOOK_URL = "https://integram.org/webhook/cwTL5AuH5tF"

  def perform(message)
    return if QA_MODE

    uri = URI.parse(WEBHOOK_URL)
    request = Net::HTTP::Post.new(uri)
    request.body = JSON.dump('text' => message)

    req_options = {
      use_ssl: uri.scheme == "https"
    }

    Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end
end
