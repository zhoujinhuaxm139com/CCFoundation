Pod::Spec.new do |spec|
  spec.name         = "CCFoundation"
  spec.version      = "1.0.4"
  spec.summary      = "个人自用库"
  spec.description  = <<-DESC
                    Features:
                    1.个人自用库
                    2.导航栏管理
                    3.闪退的处理
                   DESC
  spec.homepage     = "https://www.baidu.com/"
  spec.license      = "MIT"
  spec.author       = { "周金华" => "zhoujinhua_xm@139.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/zhoujinhuaxm139com/CCFoundation.git", :tag => spec.version }
  spec.source_files = 'CCFoundation/CCFoundation.h'

  spec.subspec 'Category' do |ss|
    ss.ios.deployment_target = '9.0'
    ss.source_files = 'CCFoundation/Category/*.{h,m}'
  end
  
  spec.subspec 'UIKit' do |ss|
    ss.ios.deployment_target = '9.0'
    ss.source_files = 'CCFoundation/UIKit/**/*.{h,m}'
  end
end
