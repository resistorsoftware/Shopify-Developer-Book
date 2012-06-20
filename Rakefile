task :default => :docraptor

task :docraptor do
  print 'Creating Docraptor doc...'
  require 'rubygems'
  require 'doc_raptor'

  DocRaptor.api_key ENV['DRKEY']

  pdf_html = File.read('output/Shopify-Developer-Book.pdf.html')

  File.open("Shopify-Developer-Book.raptor.pdf", "w+b") do |f|
    f.write DocRaptor.create(:document_content => pdf_html,
                             :name             => "Shopify Developer Book",
                             :document_type    => "pdf",
                             :prince_options => {:baseurl => 'http://cold-journey-9230.heroku.com/'},
                             :test             => !ENV['REALDEAL'])
    print "done!\n"
  end
end

