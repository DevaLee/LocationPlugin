#
# Be sure to run `pod lib lint LocationPlugin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LocationPlugin'
  s.version          = '0.1.0'
  s.summary          = 'location plugin for iOS developer'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
iOS developer can use the plugin to get location information and also can get reversecode info
                       DESC

  s.homepage         = 'https://github.com/1260197127@qq.com/LocationPlugin'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1260197127@qq.com' => 'liyuchen@haoqipei.com' }
  s.source           = { :git => 'https://github.com/DevaLee/LocationPlugin.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LocationPlugin/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LocationPlugin' => ['LocationPlugin/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
