class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category

  has_attached_file :avatar, styles: { large: "500x500#", medium: "300x300#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates_presence_of :name, :current_price, :quantity, :description, :brand, :category

  validates_numericality_of :current_price, greater_than_or_equal_to: 0.01

  validates_numericality_of :quantity, greater_than_or_equal_to: 0
# t.string   "name"
#     t.decimal  "current_price"
#     t.integer  "quantity"
#     t.text     "description"
#     t.integer  "brand_id"
#     t.integer  "category_id"
#     t.datetime "created_at",          null: false
#     t.datetime "updated_at",          null: false
#     t.string   "avatar_file_name"
#     t.string   "avatar_content_type"
#     t.integer  "avatar_file_size"
#     t.datetime "avatar_updated_at

  def self.search_by_name_or_desc(string)
    where("name LIKE ? OR description LIKE ?", "%#{string}%", "%#{string}%")
  end

end
