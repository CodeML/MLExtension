Pod::Spec.new do |spec|

  spec.name         = "MLExtension"
  spec.version      = "0.0.1"
  spec.author       = { "CoderML" => "weiminglei1990@163.com" }
  spec.homepage     = "https://github.com/CodeML/MLExtension"
  spec.summary      = "Category"
  spec.source       = { :git => "https://github.com/CodeML/MLExtension.git", :tag => "#{spec.version}" }
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.platform = :ios
  spec.requires_arc = true
  spec.source_files  = "Classes/*.{h,m}"
  spec.ios.deployment_target = '8.0'

  spec.dependency 'MBProgressHUD'
  spec.dependency 'SDWebImage'
  spec.dependency 'MJExtension'
end
