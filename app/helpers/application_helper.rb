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
            messages += '<span class="success">'"#{flash[type]}</span><br>"
          when :info
            messages += '<span class="alert alert-info">'"#{flash[type]}</span>"
          when :warning
            messages += '<span class="alert alert-danger">'"#{flash[type]}</span>"
          when :error
            messages += '<span class="error">'"#{flash[type]}</span>"
        end
      end
    end

    messages.html_safe
  end
end
