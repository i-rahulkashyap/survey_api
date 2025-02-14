class QuestionsController < ApplicationController
  before_action :set_survey
  before_action :set_question, only: [:show, :update, :destroy]

  def index
    @questions = @survey.questions
    render json: QuestionSerializer.new(@questions).serializable_hash
  end

  def show
    render json: QuestionSerializer.new(@question).serializable_hash
  end

  def create
    @question = @survey.questions.build(question_params)

    if @question.save
      render json: QuestionSerializer.new(@question).serializable_hash, status: :created
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      render json: QuestionSerializer.new(@question).serializable_hash
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    head :no_content
  end

  private

  def question_params
    params.require(:question).permit(:question_type, :text, :options, :required, :order)
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Survey not found' }, status: :not_found
  end

  def set_question
    @question = @survey.questions.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Question not found' }, status: :not_found
  end
end