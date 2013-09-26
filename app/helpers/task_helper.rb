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
      content_tag :p, task.name, class: "task-name"
    else
      content_tag(:br) + content_tag(:p, "Sem tarefa", class: "striped-warning")
    end
  end

  def task_status(task)
    return content_tag(:div, "Aguardando Aprovação", id: "warning", class: "striped-warning") unless task.approved
    content_tag(:span, "? %", class: "status") + content_tag(:p, "duração aqui", class: "hours")
  end

end