class Slack
  require 'net/http'
  require 'uri'

  CHANNEL_ID = Rails.application.credentials[:SLACK_CHANNEL_ID]
  API_KEY = Rails.application.credentials[:SLACK_API_KEY]

  def self.send_message(message)
    uri = URI.parse("https://slack.com/api/chat.postMessage")
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{API_KEY}"
    request.body = {
      "channel": CHANNEL_ID,
      "text": message
    }.to_json

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    parsed_response = JSON.parse(response.body)
    Rails.logger.info(parsed_response)

    open("public/list.txt", "a") do |f|
      f << "[#{Date.today}] #{message}\n"
    end
  end
end
