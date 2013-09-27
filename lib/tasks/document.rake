namespace :document do
  desc "Imports all doc, pdf, and txt files in root directory"
  task import: :environment do
    files = Dir.glob(Rails.root.join("*.{doc,pdf,txt}"))
    puts "Files found: #{files.count}"
    count = 1

    files.each do |file|
      doc = Document.new title: File.basename(file), doc: File.open(file)
      puts "Processing file '#{file}' [#{count}/#{files.count}]"
      doc.save
      doc.extract_content
      Sunspot.index! doc
      count += 1
    end
    puts "Importing done!"
  end

end
