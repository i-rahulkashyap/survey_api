class SurveysController < ApplicationController
  # include Pundit
  # before_action :set_current_user
  before_action :set_survey, only: [:show, :update, :destroy, :take, :distribute]
  # after_action :verify_authorized, except: [:index, :create]
  # after_action :verify_policy_scoped, only: :index

  def index
    # byebug
    @surveys = Survey.all
    render json: SurveySerializer.new(@surveys).serializable_hash
  end

  def show
    # authorize @survey
    render json: {
      id: @survey.id,
      title: @survey.title,
      description: @survey.description,
      theme: @survey.theme,
      questions: @survey.questions.map { |q| {
        id: q.id,
        text: q.text,
        question_type: q.question_type,
        options: q.options
      }}
    }
    # render json: SurveySerializer.new(@survey, include: [:questions]).serializable_hash
  end

  
  def take
    response = @survey.responses.build(response_params)

    response.user_id = @current_user.id


    if response.save
      render json: { message: 'Response submitted successfully', response: response }, status: :created
    else
      render json: { errors: response.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def create
    @survey = @current_user.surveys.build(survey_params)

    if @survey.save
      render json: SurveySerializer.new(@survey).serializable_hash, status: :created
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end
  

  def update
    if @survey.update(survey_params)
      render json: SurveySerializer.new(@survey).serializable_hash
    else
      render json: { errors: @survey.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @survey.destroy
    head :no_content
  end

  def attempted_surveys
    @attempted_surveys = Survey.joins(:responses).where(responses: { user_id: @current_user.id }).distinct

    render json: SurveySerializer.new(@attempted_surveys, { params: { current_user: @current_user } }).serializable_hash
  end


  def distribute
    emails = params[:emails]
    @survey.distribute_via_email(emails)
    render json: { message: 'Survey distributed successfully' }, status: :ok
  end

  def track
    response_rate = @survey.response_rate
    render json: { response_rate: response_rate }, status: :ok
  end

  
  private

  def survey_params
    params.require(:survey).permit(:id, :title, :description, :theme, questions_attributes: [:text, :question_type, options: []])
  end

  def set_survey
  @survey = Survey.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Survey not found' }, status: :not_found
  end

  def response_params
    # Change this to accept the correct parameter structure
    params.require(:responses).permit(:user_id, answers_attributes: [:question_id, :text_value, :file_url])
  end

  
end