Pod::Spec.new do |s|
  s.name             = 'KKCommonLib-APIManager'
  s.version          = '0.1.5'
  s.summary          = 'A CocoaPods library written in Swift'

  s.description      = <<-DESC
This CocoaPods library helps you perform calculation.
                       DESC

  s.homepage         = 'https://github.com/kk-banda-sd/KKCommonLib-APIManager'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'kk-cps' => '64898911+kk-banda-sd@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/kk-banda-sd/KKCommonLib-APIManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'

  s.source_files = 'KKCommonLib-APIManager/**/*.{h,m,swift}'

  s.xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  s.dependency 'KKCommonLib'
  s.dependency 'Alamofire'
  s.dependency 'Alamofire-SwiftyJSON'
  s.dependency 'SwiftyJSON'
end
