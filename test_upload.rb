File.write("test.epub", "dummy epub content")
e = Ebook.new(title: "Test", author: "Test", cover_image: nil)
e.file = File.open("test.epub")
e.save!(validate: false)
puts "URL: #{e.file.url}"
