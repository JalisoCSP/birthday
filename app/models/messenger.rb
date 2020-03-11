class Messenger
  def self.call
    message_birthday_users
    message_work_anniversay_users
  end

  def self.message_birthday_users
    Timetastic.birthday.each do |user|
      Slack.send_message(user.birthday_message)
    end
  end

  def self.message_work_anniversay_users
    Timetastic.anniversary.each do |user|
      Slack.send_message(user.anniversary_message)
    end
  end
end
