module TimeRelated
  include ActiveSupport
  def timezone
    return TimeZone[self.timezone_name]
  end

  def timezone_name
    return self.timezone_info.split('|').first
  end

  def timezone_short_name
    return self.timezone.now.strftime('%Z')
  end

  def utc_offset
    return self.timezone_info.split('|').last.to_i
  end
end
