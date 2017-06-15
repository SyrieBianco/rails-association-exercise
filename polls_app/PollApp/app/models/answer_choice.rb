class AnswerChoice < ApplicationRecord

  validates :question_id, :answer_choice, presence: true

  belongs_to :question,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :Question

  has_many :responses,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :Response

  has_one :poll,
    through: :question,
    source: :poll

  has_one :author,
    through: :poll,
    source: :author

end
