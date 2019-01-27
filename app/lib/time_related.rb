module TimeRelated
  def timezone
    return self.timezone_info.split('|').first
  end

  def utc_offset
    return self.timezone_info.split('|').last.to_i
  end
end
