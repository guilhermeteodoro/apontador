module ApplicationHelper
  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each do |type|
      if flash[type]
        case type
          when :notice
            messages += '<p class="alert alert-success">'"#{flash[type]}</p>"
          when :info
            messages += '<p class="alert alert-info">'"#{flash[type]}</p>"
          when :warning
            messages += '<p class="alert alert-danger">'"#{flash[type]}</p>"
          when :error
            messages += '<p class="alert alert-error">'"#{flash[type]}</p>"
        end
      end
    end

    messages.html_safe
  end
end
