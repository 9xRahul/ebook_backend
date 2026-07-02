require 'rails_helper'

RSpec.describe "Api::Ebooks", type: :request do
  before do
    Ebook.destroy_all
  end

  describe "GET /api/ebooks" do
    it "returns a list of ebooks" do
      get api_ebooks_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/ebooks" do
    it "creates a new ebook" do
      file = fixture_file_upload('dummy.pdf', 'application/pdf')
      
      expect {
        post api_ebooks_path, params: { ebook: { title: "New Book", author: "Author", file: file } }
      }.to change(Ebook, :count).by(1)
      
      expect(response).to have_http_status(201)
    end
  end
  
  describe "DELETE /api/ebooks/:id" do
    it "deletes the ebook" do
      ebook = Ebook.new(title: 'Test Book', author: 'John Doe')
      ebook.file = File.open(Rails.root.join('spec', 'fixtures', 'dummy.pdf'))
      ebook.save!
      
      expect {
        delete api_ebook_path(ebook)
      }.to change(Ebook, :count).by(-1)
      
      expect(response).to have_http_status(204)
    end
  end
end
