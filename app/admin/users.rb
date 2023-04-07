ActiveAdmin.register User do
  permit_params :email, :password, :name, :admin

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :admin
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :name
  filter :admin
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation
      f.check_box :admin
    end
    f.actions
  end

  permit_params do
    permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :admin]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

end
