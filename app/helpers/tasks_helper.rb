module TasksHelper
  def render_task_status(task)
    if task.is_hidden
      "(草稿)"
    else
      "(公开)"
    end
  end
end
