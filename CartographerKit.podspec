Pod::Spec.new do |s|
  s.name            = "CartographerKit"
  s.version         = "0.1.0"
  s.summary         = "Code for reading Cartographer files."
  s.description     = <<-DESC
                      Code for parsing Cartographer files to get the
                      annotations and shapes.
                      DESC
  s.homepage        = "http://github.com/iainx/CartographerKit"
  s.license         = 'MIT'
  s.author          = { "Iain Holmes" => "iain@falsevictories.com" }
  s.platform        = :osx, "10.9"
  s.source          = { :git => "https://github.com/iainx/CartographerKit.git", :tag => "0.1.0" }
  s.source_files    = 'CartographerKit/*.{h,m}'
  s.framework       = 'MapKit'
  s.requires_arc    = true
end
