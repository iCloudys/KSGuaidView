
Pod::Spec.new do |s|

s.name          = "KSGuaidView"
s.version       = "0.0.5"
s.summary       = "App new feature page App"
s.description   = <<-DESC
App new feature page
App新特性页面
                DESC
s.homepage      = "https://github.com/iCloudys/KSGuaidView"
s.license       = "MIT"
s.author        = { "iCloudys" => "m18301125620@163.com" }
s.platform      = :ios, "8.0"
s.source        = { :git => "https://github.com/iCloudys/KSGuaidView.git", :tag => "#{s.version}" }
s.source_files  = "KSGuaidView/*.{h,m}"
s.requires_arc  = true

end
