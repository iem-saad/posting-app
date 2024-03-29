class Post < ApplicationRecord

    belongs_to :user
    has_one_attached :image
    default_scope -> { order(created_at: :desc) }
    validates :user_id, presence: true
    validates :title, length: { maximum: 140 },
                    presence: true
    # validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
    #                                    message: "Must Be A Valid Image Formate"},
    #                   size:            { less_than: 5.megabytes,
    #                                     message: "Should Be Less Than 5MB"}

    def display_image
        image.variant(resize_to_limit: [500, 500])
    end
end