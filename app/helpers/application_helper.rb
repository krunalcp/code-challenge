module ApplicationHelper

  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def print_error(object, field)
    return if object[field].blank?

    raw("<small class='text-danger'>#{object[field].uniq.join(', ')}</small>")
  end
end
