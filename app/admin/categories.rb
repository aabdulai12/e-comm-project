ActiveAdmin.register Category do
  permit_params :title, :description, :other_attributes

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      # Add any other existing attributes as needed
    end
    f.actions
  end
end
