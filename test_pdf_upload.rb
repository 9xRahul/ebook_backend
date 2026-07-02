File.write("test.pdf", "%PDF-1.4\n1 0 obj\n<<>>\nendobj\ntrailer\n<<>>\n%%EOF")
e = Ebook.new(title: "Test PDF Real", author: "Test", cover_image: nil)
e.file = File.open("test.pdf")
e.save!(validate: false)
puts "URL: #{e.file.url}"
