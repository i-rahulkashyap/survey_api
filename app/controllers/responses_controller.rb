class ResponsesController < ApplicationController
  before_action :set_survey
  before_action :set_response, only: [:show, :update, :destroy, :answers]

  def index
    @responses = @survey.responses
    render json: @responses.map { |response| ResponseSerializer.new(response).serializable_hash }
  end

  def show
    render json: ResponseSerializer.new(@response).serializable_hash
  end

  def create
    @response = @survey.responses.build(response_params)

    if @response.save
      render json: ResponseSerializer.new(@response).serializable_hash, status: :created
    else
      render json: { errors: @response.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @response.update(response_params)
      render json: ResponseSerializer.new(@response).serializable_hash
    else
      render json: { errors: @response.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @response.destroy
    head :no_content
  end

  # def answers
  #   byebug
  #   render json: @response.answers.map { |answer| AnswerSerializer.new(answer).serializable_hash }
  # end

  def answers
    @answers = @response.answers.includes(:question)
    render json: {
      data: @answers.map do |answer|
        {
          id: answer.id,
          type: 'answer',
          attributes: {
            question_id: answer.question_id,
            question_text: answer.question.text,
            text_value: answer.text_value,
            file_url: answer.file_url
          }
        }
      end
    }
  end

  private

  def response_params
    params.require(:response).permit(:user_id, answers_attributes: [:question_id, :text_value, :file_url])
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Survey not found' }, status: :not_found
  end

  def set_response
    @response = @survey.responses.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Response not found' }, status: :not_found
  end
end