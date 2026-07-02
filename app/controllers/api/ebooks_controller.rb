module Api
  class EbooksController < ApplicationController
    before_action :set_ebook, only: [:show, :destroy, :download]

    rescue_from StandardError, with: :handle_standard_error
    rescue_from Mongoid::Errors::DocumentNotFound, with: :handle_not_found

    # GET /api/ebooks
    def index
      @ebooks = Ebook.all.order(created_at: :desc)
      render json: { 
        success: true, 
        message: 'Ebooks retrieved successfully', 
        data: @ebooks.map { |ebook| serialize_ebook(ebook) } 
      }, status: :ok
    end

    # GET /api/ebooks/search?q=keyword
    def search
      query = params[:q]
      @ebooks = Ebook.search(query).order(created_at: :desc)
      render json: { 
        success: true, 
        message: 'Search completed successfully', 
        data: @ebooks.map { |ebook| serialize_ebook(ebook) } 
      }, status: :ok
    end

    # GET /api/ebooks/:id
    def show
      render json: { 
        success: true, 
        message: 'Ebook retrieved successfully', 
        data: serialize_ebook(@ebook) 
      }, status: :ok
    end

    # POST /api/ebooks
    def create
      @ebook = Ebook.new(ebook_params)

      if @ebook.save
        render json: { 
          success: true, 
          message: 'Ebook uploaded successfully', 
          data: serialize_ebook(@ebook) 
        }, status: :created
      else
        render json: { 
          success: false, 
          message: 'Failed to upload ebook', 
          errors: @ebook.errors.full_messages 
        }, status: :unprocessable_entity
      end
    end

    # DELETE /api/ebooks/:id
    def destroy
      if @ebook.destroy
        render json: { 
          success: true, 
          message: 'Ebook deleted successfully' 
        }, status: :ok
      else
        render json: { 
          success: false, 
          message: 'Failed to delete ebook',
          errors: @ebook.errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    # GET /api/ebooks/:id/download
    def download
      if @ebook.file.url.present?
        render json: { 
          success: true, 
          message: 'Download URL retrieved successfully', 
          data: { download_url: @ebook.file.url } 
        }, status: :ok
      else
        render json: { 
          success: false, 
          message: 'File not available for download' 
        }, status: :not_found
      end
    end

    private

    def set_ebook
      @ebook = Ebook.find(params[:id])
    end

    def handle_not_found
      render json: { 
        success: false, 
        message: 'Ebook not found' 
      }, status: :not_found
    end

    def handle_standard_error(exception)
      render json: { 
        success: false, 
        message: 'An unexpected error occurred', 
        error: exception.message 
      }, status: :internal_server_error
    end

    def ebook_params
      # Support flat parameters for multipart/form-data as well as nested :ebook params
      if params[:ebook].present?
        params.require(:ebook).permit(:title, :author, :file_type, :file_size, :file, :cover_image)
      else
        params.permit(:title, :author, :file_type, :file_size, :file, :cover_image)
      end
    end

    def serialize_ebook(ebook)
      {
        id: ebook.id.to_s,
        title: ebook.title,
        author: ebook.author,
        file_type: ebook.file_type,
        file_size: ebook.file_size,
        upload_date: ebook.created_at,
        file_url: ebook.file.url,
        cover_image_url: ebook.cover_image.url
      }
    end
  end
end
