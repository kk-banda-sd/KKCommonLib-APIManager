Pod::Spec.new do |s|
  s.name             = 'KKCommonLib-APIManager'
  s.version          = '0.1.12'
  s.summary          = 'A CocoaPods library written in Swift'

  s.description      = <<-DESC
This CocoaPods library helps you perform calculation.
                       DESC

  s.homepage         = 'https://github.com/kk-banda-sd/KKCommonLib-APIManager'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'kk-cps' => '64898911+kk-banda-sd@users.noreply.github.com' }

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.7'

  s.source           = { :git => 'https://github.com/kk-banda-sd/KKCommonLib-APIManager.git', :tag => s.version.to_s }
  s.source_files = 'KKCommonLib-APIManager/**/*.{h,m,swift}'
  
  s.dependency 'KKCommonLib'
  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
end
