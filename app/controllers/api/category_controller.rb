class Api::CategoryController < Api::BaseApiController
  before_action :find_category, except: [:index, :create]
  before_action :find_category_by_description, only: [:create]

  def index
    @category = Category.all
    render json: @category
  end

  def create
    if @category.nil?
      @category = Category.new(description: params_category[:description])
      if @category.save
        render json: @category
      else
        render json: "Category #{@category.description} already exists.", status: 400
      end
    else
      render json: "It was not possible to create #{@category.description}", status: 500
    end
  end

  def show
    render json: @category
  end

  def update
    if @category.update(params_category)
      render json: @category
    else
      render json: "Category #{@category.description} already exists.", status: 400
    end
  end

  def destroy
    id = @category.id
    if @category.destroy
      render json: id
    else
      render json: "Can't destroy #{@category.description}"
    end
  end

  private
    def params_category
      params.require(:category).permit(:id, :description)
    end

    def find_category
      @category = Category.find(params_category[:id])
    end

    def find_category_by_description
      @category = Category.find_by_description(params_category[:description])
    end
end
