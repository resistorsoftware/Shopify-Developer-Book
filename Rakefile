task :default => :docraptor

desc "Creates PDF via DocRaptor"
task :docraptor do
  print 'Creating DocRaptor doc...'
  require 'doc_raptor'

  DocRaptor.api_key ENV['DRKEY']

  pdf_html = File.read('output/Shopify-Developer-Book.html').gsub(/[^[:ascii:]]/) {|c| "&#x%X;" % c.ord}

  File.open("output/Shopify-Developer-Book.raptor.pdf", "w+") do |f|
    f.write DocRaptor.create(:document_content => pdf_html,
                             :name             => "Shopify Developer Book",
                             :document_type    => "pdf",
                             :prince_options => {:baseurl => 'http://cold-journey-9230.heroku.com/'},
                             :test             => !ENV['REALDEAL'])
    print "done!\n"
  end
end

