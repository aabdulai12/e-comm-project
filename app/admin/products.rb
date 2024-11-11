ActiveAdmin.register Product do
  menu :priority => 1
  permit_params :name, :description, :category_id, :price, :sale_price, :stock_quantity, :image
  
  index do
    column :name
    column :description
    column :category
    column :stock_quantity
    column :price, :sortable => :price do |product|
      div :class => "price" do
        number_to_currency product.price, :unit => "&dollar;"
      end
    end
    column :sale_price, :sortable => :sale_price do |product|
      div :class => "Sale Price" do
        number_to_currency product.sale_price, :unit => "&dollar;"
      end
    end
    actions
  end

  form do |f|                         
    f.inputs "Details" do       
      f.input :name                  
      f.input :description, :as => :ckeditor
      f.input :category
      f.input :price
      f.input :sale_price
      f.input :stock_quantity
      f.input :image, :as => :file
    end                               
    f.actions                         
  end 
end
