class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = current_user.contacts
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @old_user = User.where(email: params["contact"]["email_id"]).first
    @user = @old_user.nil? ? User.create(email: params["contact"]["email_id"]) : @old_user
    OrganizationUser.where(user_id: @user.id, organization_id: current_org.id).first_or_create
    @contact = @user.contacts.new(contact_params)
    @contact.organization = current_org
    if contact_params["phone_number"]!=nil
      @contact.phone_number = "0"+contact_params["phone_number"].gsub(/\s+/,"").slice(-10,10)
      if !Contact.where(phone_number: @contact.phone_number).empty? 
        @contact.confirmed_at = Contact.where(phone_number: @contact.phone_number).order(confirmed_at: :desc).last.confirmed_at
      end
    end
    respond_to do |format|
      if @contact.save
        if current_org.escalation_rules.empty? and !current_user.tour_taken
          @escalation_rule = current_org.escalation_rules.create(name: 'Sample Rule')
          Level.create(escalation_rule: @escalation_rule, contact_id: @contact.id, level_number: 1)
        end
        if !(current_user.email == @user.email)
          OnboardingMailer.send_invitation_email(
            @user, @contact.name, current_user.contacts.first.name,
            @contact.phone_number, current_org.name).deliver!
        end
        format.html { redirect_to settings_path, notice: 'Team Member was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.json { render json: {error: @contact.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        @contact.phone_number = "0"+contact_params["phone_number"].gsub(/\s+/,"").slice(-10,10)
        @contact.save
        format.html { redirect_to settings_path, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to settings_path, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:name, :phone_number, :email_id)
  end
end
