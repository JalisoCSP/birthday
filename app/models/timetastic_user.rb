class TimetasticUser
  YEARLESS_FORMAT = "%d-%m"

  def initialize(params)
    @user = params
  end

  def name
    "#{@user["firstname"]} #{@user["surname"]}"
  end

  def age
    Date.today.year - @user["birthday"].to_date.year
  end

  def work_age
    Date.today.year - @user["startDate"].to_date.year
  end

  def birthday_today?
    date_is_today?(@user["birthday"])
  end

  def anniversary_today?
    date_is_today?(@user["startDate"])
  end

  def birthday_message
    "Happy birthday, #{name} - #{age} today!"
  end

  def anniversary_message
    "Happy work anniversary, #{name} - #{work_age} #{"year".pluralize(work_age)} at Yozu today!"
  end

  private

  def date_is_today?(date)
    if date
      date.to_date.strftime(YEARLESS_FORMAT) == Date.today.strftime(YEARLESS_FORMAT)
    else
      false
    end
  end
end
