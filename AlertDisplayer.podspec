#
# Be sure to run `pod lib lint AlertDisplayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AlertDisplayer'
  s.version          = '0.1.3'
  s.summary          = 'AlertDisplayer is a custom UIView Written In Swift that display an alert.'
  s.swift_versions = '4.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
AlertDisplayer is a custom UIView Written In Swift that display a view with 1 label with a title, 1 exit image and 2 posible button. Everything customizable through a delegate.
                       DESC

  s.homepage         = 'https://github.com/JCTec/AlertDisplayer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JCTec' => 'jc_estevezr@hotmail.com' }
  s.source           = { :git => 'https://github.com/JCTec/AlertDisplayer.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/EstevezrJc'

  s.ios.deployment_target = '11.0'

  s.source_files = 'AlertDisplayer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AlertDisplayer' => ['AlertDisplayer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
