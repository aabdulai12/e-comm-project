ActiveAdmin.register Status do
    # Permit parameters for strong parameter protection
    permit_params :title, :description
  
    # Customize the index page
    index do
      selectable_column
      id_column
      column :title
      column :description
      column :created_at
      column :updated_at
      actions
    end
  
    # Customize the form
    form do |f|
      f.inputs do
        f.input :title
        f.input :description
      end
      f.actions
    end
  
    # Show individual record details
    show do
      attributes_table do
        row :id
        row :title
        row :description
        row :created_at
        row :updated_at
      end
    end
  end
  