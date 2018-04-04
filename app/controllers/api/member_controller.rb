class Api::MemberController < Api::BaseApiController
  before_action :find_member, except: [:index, :create]
  before_action :find_member_by_email, only: [:create]

  def index
    @member = Member.all
    render json: @member
  end

  def create
    if @member.nil?
      @member = Member.new(email: params_member[:email])
      if @member.save
        render json: @member
      else
        render json: "Member #{@member.email} already exists.", status: 400
      end
    else
      render json: "It was not possible to create #{@member.email}", status: 500
    end
  end

  def show
    render json: @member
  end

  def update
    if @member.update(params_member)
      render json: @member
    else
      render json: "Member #{@member.email} already exists.", status: 400
    end
  end

  def destroy
    id = @member.id
    if @member.destroy
      render json: id
    else
      render json: "Can't destroy #{@member.email}"
    end
  end

  private
    def params_member
      params.require(:member).permit(:id, :email)
    end

    def find_member
      @member = Member.find(params_member[:id])
    end

    def find_member_by_email
      @member = Member.find_by_email(params_member[:email])
    end
end
