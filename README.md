# Libiris Backend API

This repository contains the backend API for the Libiris Flutter application. It is built using Ruby on Rails and provides a robust, scalable service for uploading, managing, and retrieving PDF and EPUB ebooks.

## Technology Stack

- **Backend Framework:** Ruby on Rails
- **Database:** MongoDB (via Mongoid ODM)
- **Cloud Storage:** Cloudinary (via CarrierWave)
- **Frontend:** Flutter (Mobile & Desktop)

## Architecture Overview

- **MongoDB** is used as the primary database to store ebook metadata (title, author, file size, file type, upload date).
- **Cloudinary** is used as the cloud storage provider to host the actual `.pdf` / `.epub` files as well as the ebook cover images.
- **Rails API** acts as the middleware, receiving multipart file uploads from the Flutter app, securely storing them in Cloudinary, and saving the generated CDN URLs in MongoDB.

## API Endpoints

The API is mounted under the `/api` namespace and returns data in JSON format.

### 1. Retrieve All Ebooks
- **Endpoint:** `GET /api/ebooks`
- **Description:** Returns a list of all uploaded ebooks, sorted by the newest uploads first.
- **Response Structure:**
  ```json
  {
    "success": true,
    "message": "Ebooks retrieved successfully",
    "data": [
      {
        "id": "6a44f1c...",
        "title": "The Moon",
        "author": "Dr Nicholas",
        "file_type": "application/pdf",
        "file_size": 1024500,
        "upload_date": "2026-07-01T10:00:00.000Z",
        "file_url": "https://res.cloudinary.com/.../the_moon.pdf",
        "cover_image_url": "https://res.cloudinary.com/.../cover.jpg"
      }
    ]
  }
  ```

### 2. Search Ebooks
- **Endpoint:** `GET /api/ebooks/search?q={keyword}`
- **Description:** Searches the database for ebooks matching the keyword in their title or author fields.
- **Response Structure:** Same as `GET /api/ebooks`.

### 3. Upload a New Ebook
- **Endpoint:** `POST /api/ebooks`
- **Content-Type:** `multipart/form-data`
- **Parameters:**
  - `title` (String) - The title of the book
  - `author` (String) - The author of the book
  - `file` (File) - The PDF or EPUB file
  - `cover_image` (File) - The cover image (PNG/JPEG)
- **Description:** Uploads the files directly to Cloudinary and saves the metadata to MongoDB.
- **Response Structure (201 Created):**
  ```json
  {
    "success": true,
    "message": "Ebook uploaded successfully",
    "data": { ...ebook_object... }
  }
  ```

### 4. Get a Specific Ebook
- **Endpoint:** `GET /api/ebooks/:id`
- **Description:** Retrieves the metadata for a specific ebook by its MongoDB ObjectId.

### 5. Get Ebook Download URL
- **Endpoint:** `GET /api/ebooks/:id/download`
- **Description:** Retrieves the direct Cloudinary CDN download URL for the requested ebook file.

### 6. Delete an Ebook
- **Endpoint:** `DELETE /api/ebooks/:id`
- **Description:** Deletes the ebook metadata from MongoDB and destroys the associated files hosted on Cloudinary.

## Setup & Installation

1. Install Ruby and Rails.
2. Clone the repository and run `bundle install`.
3. Configure your MongoDB connection in `config/mongoid.yml`.
4. Add your Cloudinary credentials (Cloud Name, API Key, API Secret) to your environment variables.
5. Start the server using:
   ```bash
   rails s -b 0.0.0.0
   ```
   *(Note: Binding to 0.0.0.0 ensures the API is accessible to physical mobile devices on the same Wi-Fi network during local development).*
