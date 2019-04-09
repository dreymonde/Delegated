Pod::Spec.new do |s|
  s.name         = "Delegated"
  s.version      = "0.1.2"
  s.summary      = "Closure-based delegation without memory leaks"
  s.description  = <<-DESC
    Delegated is a super small package that solves the retain cycle problem when dealing with closure-based delegation.
  DESC
  s.homepage     = "https://github.com/dreymonde/Delegated"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Oleg Dreyman" => "dreymonde@me.com" }
  s.social_media_url   = "https://twitter.com/olegdreyman"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/dreymonde/Delegated.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
