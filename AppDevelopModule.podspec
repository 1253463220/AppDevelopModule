#
# Be sure to run `pod lib lint Wlw.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppDevelopModule'
  s.version          = '1.0.0'
  s.summary          = 'iOS App开发工具集合'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
iOS App开发工具集合,以Swift为主。
                       DESC

  s.homepage         = 'https://github.com/王立/Wlw'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '王立' => '1253463220@qq.com' }
  s.source           = { :git => 'https://github.com/王立/Wlw.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.default_subspecs = 'Core','Picture','Hud','Algorithms'
  s.swift_version = ['5.0', '4.2', '4.0']
  s.frameworks = 'Foundation','UIKit'
#  s.source_files = 'AppDevelopModule/**/*'
  
  s.subspec 'Core' do |ss|
    ss.source_files = 'AppDevelopModule/Core/**/*'
    ss.dependency 'SwifterSwift'
  end
  
  s.subspec 'Picture' do |ss|
    ss.source_files = 'AppDevelopModule/Picture/**/*'
    ss.dependency 'JXPhotoBrowser'
    ss.dependency 'Kingfisher'
  end
  
  s.subspec 'Hud' do |ss|
    ss.source_files = 'AppDevelopModule/Hud/**/*'
    ss.dependency 'MBProgressHUD'
    ss.dependency 'SVProgressHUD'
    ss.dependency 'NVActivityIndicatorView'
  end
  
  s.subspec 'Algorithms' do |ss|
    ss.source_files = 'AppDevelopModule/Algorithms/**/*'
  end
  
  
  # s.resource_bundles = {
  #   'Wlw' => ['Wlw/Assets/*.png']
  # }

#   s.public_header_files = 'AppDevelopModule/**/WlwPublic.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  #TZImagePickerController,SwiftDate,KMPlaceholderTextView,FSCalendar,IQKeyboardManagerSwift
end
