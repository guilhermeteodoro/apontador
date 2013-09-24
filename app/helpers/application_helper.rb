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
            if flash[type].kind_of? Array
              messages += '<div class="error">'
              messages += '<p class="close"></p>'
              flash[:error].each{|f| messages += "<p>#{f}</p>"}
              messages += '</div>'
            else
              messages += '<p class="alert alert-error">'"#{flash[type]}</p>"
            end
        end
      end
    end

    messages.html_safe
  end
end
