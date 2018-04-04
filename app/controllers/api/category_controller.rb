class Api::CategoryController < Api::BaseApiController
  before_action :find_category, except: [:index]

  def index
    puts('>>>>>>>>>>>>>>>')
    categories = Category.first
    puts(categories)
    render json: categories
  end

  def create
    if !@category
      @category = Category.new(params[:description])
      if @category.save
        render json: @category
      else
        render json: "It was not possible to create #{@category.description}", status: 500
      end
    else
      render json: "Category #{@category.description} already exists.", status: 400
    end
  end

  def show
    render json: @category
  end

  def update
    if @category.update(params_customer[:description])
      render json: @category
    else
      render json: "It was not possible to update #{category.description}", status: 500
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
    def find_category
      @category = Category.find_by_description(params[:description])
      render nothing: true, status: :not_found unless @category.present?
    end
end
