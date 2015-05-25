class ConfirmationsController < Devise::ConfirmationsController
   def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with_navigational(resource){ redirect_to confirmed_email_path }
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render_with_scope :new }
    end
  end


  def confirmed_email
    unregistered_phone_number
    last_confirmed_phone_number unless @unregistered_phone_number
    render :template => 'devise/confirmations/confirmed_email'
  end

  def check_phone_number_verification_status
    unregistered_phone_number 
    last_confirmed_phone_number unless @unregistered_phone_number
    render :template => 'devise/confirmations/check_phone_number_verification_status'
  end

  private
  def unregistered_phone_number
    @unregistered_phone_number = current_user.contacts.select(&:unverified?).first
    if @unregistered_phone_number
      @unregistered_phone_number =  secure_phone_number @unregistered_phone_number.phone_number
      
    end
  end

  def secure_phone_number phone_number
    phone_number = phone_number.split('')
    phone_number.each_with_index do |number, index|
      if index > 3 and index < 9
        phone_number[index] = '*'
      end
    end
    phone_number.empty? ? nil : phone_number.join('')
  end

  def last_confirmed_phone_number
     @phone_number = Contact.where(user: current_user).order(confirmed_at: :desc).first.phone_number
     @phone_number = secure_phone_number @phone_number if @phone_number
  end
end
