# Libiris - Backend API

## Project Overview
Libiris is a modern, full-stack Ebook Reader application that allows users to upload, manage, search, and read PDF and EPUB files seamlessly. This repository contains the **Ruby on Rails backend** which serves as the central API, managing metadata in MongoDB and orchestrating file uploads to Cloudinary.

## Tech Stack
* **Backend Framework:** Ruby on Rails (API Only Mode)
* **Database:** MongoDB (via Mongoid ODM)
* **Cloud Storage:** Cloudinary (via CarrierWave)
* **Frontend:** Flutter (Mobile/Desktop)

## Setup Instructions
1. Ensure you have **Ruby** and **Rails** installed on your system.
2. Clone this repository and navigate to the root directory.
3. Run `bundle install` to install all required dependencies.
4. Set up your MongoDB connection string in `config/mongoid.yml`.
5. Create a `.env` file in the root directory and add your Cloudinary credentials:
   ```env
   CLOUDINARY_CLOUD_NAME=your_cloud_name
   CLOUDINARY_API_KEY=your_api_key
   CLOUDINARY_API_SECRET=your_api_secret
   ```

## How to run backend
To start the Rails server and make it accessible to mobile devices on your local network, bind it to `0.0.0.0`:
```bash
rails s -b 0.0.0.0 -p 3000
```

## How to run Flutter app
1. Navigate to the companion Flutter repository (`ebook_reader`).
2. Run `flutter pub get` to install dependencies.
3. Connect an emulator or physical device.
4. Run `flutter run`.
*(Note: If testing on a physical device over USB, ensure you run `adb reverse tcp:3000 tcp:3000` so the device can access this local backend).*

## How to run tests
To execute the backend test suite, run:
```bash
rails test
```
*(If RSpec is configured, run `bundle exec rspec` instead).*

## API Overview
The API returns JSON and is mounted under the `/api` namespace:
* `GET /api/ebooks` - Retrieve all ebooks (sorted by newest).
* `GET /api/ebooks/search?q=keyword` - Search ebooks by title or author.
* `GET /api/ebooks/:id` - Retrieve a specific ebook's metadata.
* `POST /api/ebooks` - Upload a new ebook (multipart form-data: `title`, `author`, `file`, `cover_image`).
* `DELETE /api/ebooks/:id` - Delete an ebook and its Cloudinary assets.
* `GET /api/ebooks/:id/download` - Get the direct Cloudinary CDN download URL.

## Known Limitations
* **Search Performance:** The current search implementation uses regular expressions in MongoDB. For production scale (millions of books), this should be migrated to MongoDB Text Indexes (`$text`).
* **Upload Limits:** Very large PDF/EPUB files may experience timeouts on slow network connections during the Cloudinary upload phase.

## AI Tools Used and How They Were Used
This project was developed with the assistance of **DeepMind's Agentic Coding Assistant (Antigravity)**. The AI was used to:
1. **Architect the Backend:** Scaffold the Rails API, configure Mongoid for NoSQL, and integrate CarrierWave with Cloudinary.
2. **Debug Networking:** Diagnose and resolve complex localhost routing issues between Windows, Android Emulators (`10.0.2.2`), and Physical Android devices using `adb reverse` tunneling.
3. **Write Documentation:** Generate comprehensive, interview-ready documentation and README files.
