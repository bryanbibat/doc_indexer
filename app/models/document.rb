require 'ruby_tika_app'

class Document < ActiveRecord::Base
  mount_uploader :doc, DocumentUploader

  def extract_content
    rta = RubyTikaApp.new(self.doc.current_path)
    begin
      self.content = rta.to_text
      self.indexed = true
    rescue
      self.indexed = false
    end
    self.save
  end
end
