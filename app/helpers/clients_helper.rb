module ClientsHelper
  def formatted_address_haml(client)
    return render_haml <<-ADDR, client: client
      -unless client.addr1.blank?
        =client.addr1
        %br
      -unless client.addr2.blank?
        =client.addr2
        %br
      =[client.town, client.state].compact.join(', ')
    ADDR
  end

  def age_calc(date)
    return nil unless date.is_a? Date
    diff = Date.today.year - date.year
    return "(#{diff})"
  end
end
