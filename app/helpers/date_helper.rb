module DateHelper
  def short_date(date)
    return "" if date.nil?
    date.to_formatted_s(:short)
  end
end
