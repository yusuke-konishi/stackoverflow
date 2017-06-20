class Question < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  has_many :tags, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :question_votes, dependent: :destroy
  has_many :question_vote_users, through: :question_vote, source: :user

  acts_as_taggable
end
