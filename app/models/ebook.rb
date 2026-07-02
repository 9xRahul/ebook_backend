class Ebook
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :author, type: String
  field :file_type, type: String
  field :file_size, type: Integer

  mount_uploader :file, EbookUploader
  mount_uploader :cover_image, CoverUploader

  validates :title, presence: true
  validates :file, presence: true

  before_validation :set_metadata_from_file

  def self.search(keyword)
    return all if keyword.blank?
    
    regexp = /#{Regexp.escape(keyword)}/i
    any_of({ title: regexp }, { author: regexp })
  end

  private

  def set_metadata_from_file
    if file.present?
      self.file_type ||= file.file.extension if file.file.respond_to?(:extension)
      self.file_size ||= file.file.size if file.file.respond_to?(:size)
    end
  end
end
