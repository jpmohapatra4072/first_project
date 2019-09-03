class Painting < ApplicationRecord
	belongs_to :user

	# validations
	  has_attached_file :painting, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	  validates_attachment_content_type :painting, content_type: /\Aimage\/.*\z/
end
