class Api::AdController < Api::BaseApiController
  before_action :find_ad, except: [:index, :create]

  def index
    @ad = Ad.all
    render json: @ad
  end

  def show
    render json: @ad
  end

  def create
    @ad = Ad.new(params_ad)
    if @ad.save
      render json: @ad
    else
      render nothing: true, status: 400
    end
  end

  def update
    if @ad.update(params_ad)
      render json: @ad
    else
      render json: "Ad #{@ad.description} already exists.", status: 400
    end
  end

  def destroy
    id = @ad.id
    if @ad.destroy
      render json: id
    else
      render json: "Can't destroy #{@ad.description}"
    end
  end


  private
    def params_ad
      params.require(:ad).permit(:id, :title, :category_id, :price, :description, :description_md, :description_short, :picture, :finish_date)
    end

    def find_ad
      @ad = Ad.find(params_ad[:id])
    end
end
