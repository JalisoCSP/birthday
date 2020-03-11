class Timetastic
  require 'net/http'
  require 'uri'

  API_KEY = Rails.application.credentials[:TIMETASTIC_API_KEY]

  def self.all
    @users ||= users
  end

  def self.birthday
    all.map do |user|
      tu = TimetasticUser.new(user)
      tu if tu.birthday_today?
    end.compact
  end

  def self.anniversary
    all.map do |user|
      tu = TimetasticUser.new(user)
      tu if tu.anniversary_today?
    end.compact
  end

  private

  def self.users
    uri = URI.parse("https://app.timetastic.co.uk/api/users")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{API_KEY}"

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end
end
