module ApplicationHelper
  def errors_restricted_cs (number_of_errors)
    if number_of_errors == 1
      return "1 chyba zabránila"
    end
    if number_of_errors <= 4
      puts number_of_errors
      return "#{number_of_errors} chyby zabránily"
    end
    if number_of_errors > 4
      return "#{number_of_errors} chyb zabránilo"
    end
  end
  
  def days_to_pay_cs (number_of_days)
    if number_of_days < 0
      return "ještě dnes"
    end
    if number_of_days == 1
      return "do jednoho dne"
    end
    if number_of_days > 1
      return "do #{number_of_days} dní"
    end
  end
  
  def insert_line
    return "<hr class=\"line_between_details\" />".html_safe
  end
end
