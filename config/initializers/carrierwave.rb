CarrierWave.configure do |config|
  # Disable deleting tmp files after storage to prevent Errno::EACCES (Permission denied) on Windows
  # because Windows locks the file while it's still open in the Ruby process.
  config.delete_tmp_file_after_storage = false
end

module CarrierWave
  class SanitizedFile
    alias_method :original_delete, :delete
    
    def delete
      original_delete
    rescue Errno::EACCES
      # Ignore EACCES on Windows due to file locking issues
      true
    end
  end
end

