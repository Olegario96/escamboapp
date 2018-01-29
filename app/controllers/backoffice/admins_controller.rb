class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]

  def index
    @admins = Admin.with_restricted_access
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to backoffice_admins_path, notice: "O adminstrador #{@admin.email} foi registrado!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @admin.update(params_admin)
      redirect_to backoffice_admins_path, notice: "O adminstrador #{@admin.email} foi alterado!"
    else
      render :edit
    end
  end

  def destroy
    admin_email = @admin.email
    if @admin.destroy
      redirect_to backoffice_admins_path, notice: "O adminstrador #{admin_email} foi apagado!"
    else
      render :index
    end
  end

  private
    def set_admin
      @admin = Admin.find(params[:id])
    end

    def params_admin
      password = params[:admin][:password]
      password_confirmation = params[:admin][:password_confirmation]

      if password.blank? && password_confirmation.blank?
        params[:admin].except!(:password, :password_confirmation)
      end

      params.require(:admin).permit(:name, :email, :password, :password_confirmation)
    end
end
