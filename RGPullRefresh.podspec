
Pod::Spec.new do |s|



  s.name         = "RGPullRefresh"
  s.version      = "1.0.0"
  s.summary      = "Just a PullRefresh."

  s.homepage     = "https://github.com/sunnyGT/RGPullRefresh"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "Robin" => "a184820975@sina.cn" }

  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/sunnyGT/RGPullRefresh.git", :tag => s.version }

  s.source_files  = "RGPullRefresh/*"


  s.requires_arc = true
end
