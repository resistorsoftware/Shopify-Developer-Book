use Rack::Static, :urls => ["/templates", "/images"]
run lambda { |e| [200, {'Content-Type' => 'text/plain'}, ["ok"]] }
