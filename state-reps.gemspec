spec = Gem::Specification.new do |s| 
  s.name = "State Reps"
  s.version = "0.1"
  s.author = "Daniel Jackoway"
  s.email = "jackowayed@gmail.com"
  s.homepage = "http://github.com/jackowayed/state-reps/"
  s.platform = Gem::Platform::RUBY
  s.summary = "Determines person's state senate and representative districts. Setup for Delaware, but may work on other states"
  s.files = FileList["{bin,lib}/**/*"].to_a
  s.require_path = "lib"
  s.autorequire = "name"
  s.has_rdoc = true
  s.add_dependency("dependency", ">= 0.x.x")
end