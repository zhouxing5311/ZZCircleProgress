Pod::Spec.new do |s|

  s.name         = "ZZCircleProgress"
  s.version      = "1.0.1"
  s.summary      = "The most easy way for circle progress. You can change the reduce angle and decide if show the cursor or not"
  s.homepage     = "https://github.com/zhouxing5311/ZZCircleProgress"
  s.license      = "MIT"
  s.author       = { "zhouxing5311" => "1098660224@qq.com" }
  s.platform     = :ios, "7.0"  
  s.source       = { :git => "https://github.com/zhouxing5311/ZZCircleProgress.git", :tag => s.version.to_s}
  s.source_files = "ZZCircleProgressDemo/ZZCircleProgress/**/*.{h,m}"
  s.resources    = 'ZZCircleProgressDemo/ZZCircleProgress/ZZCircleBundle.bundle'
  s.requires_arc = true

end
