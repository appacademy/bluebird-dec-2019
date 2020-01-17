# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :string           not null
#  author_id  :integer          not null
#  chirp_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
    validates :body, :author_id, :chirp_id, presence: true

    belongs_to :author, 
        foreign_key: :author_id,
        class_name: :User

    belongs_to :chirp, 
        foreign_key: :chirp_id,
        class_name: :Chirp

end
