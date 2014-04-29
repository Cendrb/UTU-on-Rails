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
end
