class Transaction
  #include ActiveModel::Validations
  attr_reader :id, :transaction_token, :merchant_id, :user_id, :status,
              :other_params, :event_id, :amount_in_paise, :event_id

  def initialize(params)
    @id = params['id']
    @event_id =  params['event_id'] || params[:event_id]
    @transaction_token = params['transaction_token']
    @merchant_id = params['merchant_id']
    @user_id = params['user_id']
    @status = params['status']
    @other_params = params['other_params']
    @event_id = params['event_id']
    @amount_in_paise = 200_00
  end

  def self.from_params(params)
    new(params)
  end
end