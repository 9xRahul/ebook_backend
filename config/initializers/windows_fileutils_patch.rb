require 'fileutils'

if Gem.win_platform?
  module FileUtils
    class Entry_
      alias_method :original_remove_file, :remove_file

      def remove_file
        original_remove_file
      rescue Errno::EACCES, Errno::ENOENT
        # Safely ignore permission denied errors on Windows
        # when something else (like an antivirus or ruby itself)
        # holds a lock on the file during CarrierWave/Cloudinary cleanup.
        true
      end
    end
  end
end
