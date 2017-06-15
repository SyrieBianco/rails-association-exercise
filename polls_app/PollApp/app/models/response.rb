class Response < ApplicationRecord

  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response, :respondent_not_author

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll

  def sibling_responses
    # Response.where.not(id: self.id)
    # .joins(:question)

    self.question.responses.where.not(id: self.id)
  end

  private

  def respondent_already_answered?
    sibling_responses.each do |response|
      if response.user_id == self.user_id
        return true
      end
    end
    false
  end

  def not_duplicate_response
    errors[:base] << "You already answered this question." if respondent_already_answered?
  end

  def author_is_respondent?
    answer_choice = AnswerChoice.find_by(id: self.answer_choice_id)

    answer_choice.author.id == self.user_id
  end


  def respondent_not_author
    errors[:base] << "You may not respond to your own poll" if author_is_respondent?
  end

end
