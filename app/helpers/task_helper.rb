module TaskHelper

  def task(employee)
    task = employee.task

    content_tag(:div, id: "task") do
      return task_name(task) unless task
      task_name(task) + task_status(task)
    end
  end

  private
  def task_name(task)
    if task
      content_tag(:a, href: tasks_path(task.to_param)) {content_tag :p, task.name, class: "task-name"}
    else
      content_tag(:br) + content_tag(:p, "Sem tarefa", class: "striped-warning")
    end
  end

  def task_status(task)
    case task.status
      when "pending"
        content_tag(:div, "Aguardando Resposta", id: "warning", class: "striped-warning")
      when "refused"
      when "waiting"
        content_tag(:br) + content_tag(:a, href: tasks_path(task.to_param)) {content_tag :span, "Responder Negociação", class: "btn btn-green"}
      when "accepted"
        content_tag(:span, "? %", class: "status") + content_tag(:p, "duração aqui", class: "hours")
    end
  end

end