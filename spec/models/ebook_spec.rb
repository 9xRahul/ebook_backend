require 'rails_helper'

RSpec.describe Ebook, type: :model do
  describe 'validations' do
    it 'is valid with a title and a file' do
      ebook = Ebook.new(title: 'Test Book', author: 'John Doe')
      ebook.file = File.open(Rails.root.join('spec', 'fixtures', 'dummy.pdf'))
      expect(ebook).to be_valid
    end

    it 'is invalid without a title' do
      ebook = Ebook.new(author: 'John Doe')
      ebook.valid?
      expect(ebook.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a file' do
      ebook = Ebook.new(title: 'Test Book')
      ebook.valid?
      expect(ebook.errors[:file]).to include("can't be blank")
    end
  end

  describe '.search' do
    before do
      @ebook1 = Ebook.new(title: 'Ruby on Rails Guide', author: 'David')
      @ebook1.file = File.open(Rails.root.join('spec', 'fixtures', 'dummy.pdf'))
      @ebook1.save!

      @ebook2 = Ebook.new(title: 'Flutter in Action', author: 'Eric')
      @ebook2.file = File.open(Rails.root.join('spec', 'fixtures', 'dummy.pdf'))
      @ebook2.save!
    end

    it 'finds ebooks by title' do
      results = Ebook.search('Ruby')
      expect(results).to include(@ebook1)
      expect(results).not_to include(@ebook2)
    end

    it 'finds ebooks by author' do
      results = Ebook.search('Eric')
      expect(results).to include(@ebook2)
      expect(results).not_to include(@ebook1)
    end
  end
end
