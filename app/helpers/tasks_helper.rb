module TasksHelper
  def render_task_status(task)
    if task.is_hidden
      content_tag(:span, "保留", :class => "fa fa-lock")
    else
      content_tag(:span, "公开", :class => "fa fa-globe")
    end
  end
end
