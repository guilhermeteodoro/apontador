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
            messages += '<div class="alert alert-error">'
            messages += '<a class="close" data-dismiss="alert" href="#">x</a>'
            flash[:error].each{|f| messages += "<p>#{f}</p>"}
            messages += '</div>'
        end
      end
    end

    messages.html_safe
  end
end
