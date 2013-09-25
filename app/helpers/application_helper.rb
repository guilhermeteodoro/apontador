module ApplicationHelper


  def error_for(record, attribute)
    message = record.errors[attribute].first
    name = t("activerecord.attributes.#{record.class.to_s.downcase}.#{attribute}").capitalize
    content_tag :span, "#{name} #{message}", class: "form-error" if message
  end

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
            messages += '<p class="error">'"#{flash[type]}</p>"
        end
      end
    end

    messages.html_safe
  end
end
