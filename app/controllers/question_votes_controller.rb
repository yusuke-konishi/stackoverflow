class QuestionVotesController < ApplicationController
  before_action :check_question_vote

  def plus
    if @question_vote.blank?
      @question_vote = current_user.question_votes.build(question_id: params[:question_id])
      @question_vote.vote_state = 1
      @question_vote.save

      @question.vote_count = @question.vote_count + 1
      @question.save

      @user.reputation_count = @user.reputation_count + 1
      @user.save

      redirect_to question_path(@question), notice: "質問に +1 投票しました"
    else
      if @question_vote.vote_state == 0
        @question_vote.vote_state = 1
        @question_vote.save

        @question.vote_count = @question.vote_count + 1
        @question.save

        @user.reputation_count = @user.reputation_count + 1
        @user.save

        redirect_to question_path(@question), notice: "質問に +1 投票しました"
      elsif @question_vote.vote_state == -1
        @question_vote.vote_state = 0
        @question_vote.save

        @question.vote_count = @question.vote_count + 1
        @question.save

        @user.reputation_count = @user.reputation_count + 1
        @user.save

        redirect_to question_path(@question), notice: "質問の投票をリセットしました"
      else # @question_vote.vote_state == 1
        redirect_to question_path(@question), notice: "同じ質問に 2 回以上 +1 投票することはできません"
      end
    end
  end

  def minus
    if @question_vote.blank?
      @question_vote = current_user.question_votes.build(question_id: params[:question_id])
      @question_vote.vote_state = -1
      @question_vote.save

      @question.vote_count = @question.vote_count - 1
      @question.save

      @user.reputation_count = @user.reputation_count - 1
      @user.save

      redirect_to question_path(@question), notice: "質問に -1 投票しました"
    else
      if @question_vote.vote_state == 0
        @question_vote.vote_state = -1
        @question_vote.save

        @question.vote_count = @question.vote_count - 1
        @question.save

        @user.reputation_count = @user.reputation_count - 1
        @user.save

        redirect_to question_path(@question), notice: "質問に -1 投票しました"
      elsif @question_vote.vote_state == 1
        @question_vote.vote_state = 0
        @question_vote.save

        @question.vote_count = @question.vote_count - 1
        @question.save

        @user.reputation_count = @user.reputation_count - 1
        @user.save

        redirect_to question_path(@question), notice: "質問の投票をリセットしました"
      else # @question_vote.vote_state == -1
        redirect_to question_path(@question), notice: "同じ質問に 2 回以上 -1 投票することはできません"
      end
    end
  end

  private
    def check_question_vote
      @question = Question.find(params[:question_id])
      @question_vote = @question.question_votes.find_by(user_id: current_user.id)
      @user = @question.user
    end
end
