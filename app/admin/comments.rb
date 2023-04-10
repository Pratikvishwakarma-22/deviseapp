ActiveAdmin.register Comment do
  index do
    selectable_column
    id_column
    column :comment
    column :commenter
    column :article
    column :article_id
    column :created_at
    column :updated_at
    actions
  end

  filter :comment
  filter :commenter
  filter :article
  filter :created_at

  # permit_params do
  #   permitted = [:commenter, :comment, :status, :article_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
