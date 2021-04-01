ActiveAdmin.register Page do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title


  form do |f|
    f.semantic_errors
    f.inputs(:title)
    f.actions
  end

  controller do
    defaults finder: :find_by_slug
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :slug]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
