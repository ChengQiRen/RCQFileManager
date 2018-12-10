#
# Be sure to run `pod lib lint RCQFileManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RCQFileManager'
  s.version          = '1.1.2'
  s.summary          = 'iOS沙盒文件浏览器'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
用于查看沙盒文件夹里面的内容, 方便复制, 移动以及删除
                       DESC

  s.homepage         = 'https://github.com/ChengQiRen/RCQFileManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rencheng11@icloud.com' => 'rencheng@himoca.com' }
  s.source           = { :git => 'https://github.com/ChengQiRen/RCQFileManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RCQFileManager/Classes/**/*'
  
  s.resource_bundles = {
    'RCQFileManager' => ['RCQFileManager/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = "Foundation","UIKit"
  # s.dependency 'AFNetworking', '~> 2.3'
end
