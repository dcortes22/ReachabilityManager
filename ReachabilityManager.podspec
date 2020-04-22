#
# Be sure to run `pod lib lint ReachabilityManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ReachabilityManager'
  s.version          = '1.0.0'
  s.summary          = 'Replacement Reachability.swift using NWPathMonitor'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  ReachabilityManager is library based on Reachability.swift which use NWPathMonitor to verify the connection status.
                       DESC

  s.homepage         = 'https://github.com/dcortes22/ReachabilityManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dcortes22' => 'dcortes22@gmail.com' }
  s.source           = { :git => 'https://github.com/dcortes22/ReachabilityManager.git', :tag => s.version.to_s }
   s.social_media_url = 'https://twitter.com/dcortes22'

  s.ios.deployment_target = '12.0'

  s.source_files = 'ReachabilityManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ReachabilityManager' => ['ReachabilityManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
