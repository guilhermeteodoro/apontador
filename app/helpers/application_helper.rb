module ApplicationHelper
  def flash_message
    messages = '<div id="messages"><p class="'
    [:notice, :info, :warning, :error].each do |type|
      if flash[type]
        case type
          when :notice
            messages += 'alert alert-success">'"#{flash[type]}</p>"
          when :info
            messages += 'alert alert-info">'"#{flash[type]}</p>"
          when :warning
            messages += 'alert alert-danger">'"#{flash[type]}</p>"
          when :error
            messages += 'alert alert-error">'"#{flash[type]}</p>"
        end
      end
    end

    messages << '</div>'
    messages.html_safe
  end
end
