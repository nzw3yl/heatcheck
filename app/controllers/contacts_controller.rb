class ContactsController < ApplicationController
    before_filter :load_contactable
    before_filter :authenticate_user!
    
    def index
      @contacts = @contactable.contacts
    end
    

    def new
      @contact = @contactable.contacts.new(:parent_id => params[:parent_id])
      @contacts = @contactable.contacts
    end

    def create
      @contact = @contactable.contacts.new(params[:contact])
      if @contact.save
        redirect_to [:show, 'contacts', @contactable]
      else
        render :new
      end
    end

    def edit
      @contact = @contactable.contacts.find(params[:id])
    end
  

    def update
      @contact = @contactable.contacts.find(params[:id])

      respond_to do |format|
        if @contact.update_attributes(params[:contact])
          format.html {   redirect_to [:show, 'contacts', @contactable], notice: 'contact was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @contact = @contactable.contacts.find(params[:id])
      @contact.destroy

      respond_to do |format|
        format.html { redirect_to [:show, 'contacts', @contactable] }
        format.json { head :no_content }
      end
    end

  private

    def load_contactable
      klass = [Customer, Partner, Provider].detect { |c| params["#{c.name.underscore}_id"]}
      @contactable = klass.find(params["#{klass.name.underscore}_id"])
    end


end
