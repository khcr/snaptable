module ButtonsHelper

  def add_button?
    Snaptable.add_button && 
    (!Snaptable.use_permission || 
    current_permission.allow_create?(params[:controller]))
  end

  def edit_button?
    Snaptable.edit_button && 
    (!Snaptable.use_permission || 
    current_permission.allow_modify?(params[:controller], "update"))
  end

  def show_button?
    Snaptable.show_button && 
    (!Snaptable.use_permission || 
    current_permission.allow_modify?(params[:controller], "read"))
  end

  def delete_button?
    Snaptable.delete_button && 
    (!Snaptable.use_permission || 
    current_permission.allow_modify?(params[:controller], "destroy"))
  end

end