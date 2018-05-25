Pod::Spec.new do |s|

  s.name         = "ZZCircleProgress"
  s.version      = "0.2.1"
  s.summary      = "The most easy way for circle progress. You can change anything you can see!"
  s.homepage     = "https://github.com/zhouxing5311/ZZCircleProgress"
  s.license      = "MIT"
  s.author       = { "zhouxing5311" => "1098660224@qq.com" }
  s.platform     = :ios, "7.0"  
  s.source       = { :git => "https://github.com/zhouxing5311/ZZCircleProgress.git", :tag => s.version.to_s}
  s.source_files = "ZZCircleProgressDemo/ZZCircleProgress/**/*.{h,m}"
  s.resources    = 'ZZCircleProgressDemo/ZZCircleProgress/ZZCircleProgress.bundle'
  s.requires_arc = true

end
