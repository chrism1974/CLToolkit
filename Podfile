# Default target gets auto created by Cocoapods
# target :default, :exclusive => true do

platform :ios, '6.0'
# inhibit_all_warnings!
link_with []

# Pods from official Cocoapods/Specs repo

target :ios do
  platform :ios, '6.0'
  link_with 'CLToolkit-ios'
  pod 'CocoaLumberjack', '~> 1.6.2'
  pod 'NSLogger', '~> 1.1'
  pod 'Base64', '~> 1.0.1'
  pod 'BlocksKit', '~> 1.8.3'
  pod 'AFNetworking', '~> 2.0.1', :inhibit_warnings => true
  pod 'ConciseKit', '~> 0.1.2'
  pod 'MagicalRecord', '~> 2.2', :inhibit_warnings => true
  pod 'libextobjc', '~> 0.3'
  pod 'ReactiveCocoa', '~> 2.1'
  pod 'ISO8601DateFormatter', '~> 0.7'
  pod 'Firebase', '~> 1.0.7'
  pod 'Kiwi', :inhibit_warnings => true
  pod 'Masonry', '~> 0.3.0'
  pod 'NSHash', '~> 1.0.1'
  pod 'AFDownloadRequestOperation', :path => '~/Code/HappyBits/AFDownloadRequestOperation'

  pod 'AWSRuntime/S3', '1.5.0.head', :inhibit_warnings => true # From Collections/Podspecs
  
end

target :osx do
  platform :osx, '10.8'
  link_with 'CLToolkit-osx'
  pod 'CocoaLumberjack', '~> 1.6.2'
  pod 'NSLogger', '~> 1.1'
  pod 'Base64', '~> 1.0.1'
  pod 'BlocksKit', '~> 1.8.3'
  pod 'AFNetworking', '~> 2.0.1', :inhibit_warnings => true
  pod 'ConciseKit', '~> 0.1.2'
  pod 'MagicalRecord', '~> 2.2', :inhibit_warnings => true
  pod 'ReactiveCocoa', '~> 2.1'
  pod 'ISO8601DateFormatter', '~> 0.7'
  pod 'Kiwi'
  # pod 'Masonry', '~> 0.3.0' # TODO: no reason masonry is not os x compatible...
  pod 'NSHash', '~> 1.0.1'

  pod 'AWSRuntime/S3', '1.5.0.head' # From Collections/Podspecs
  pod 'FirebaseMac', '1.0.1' # From Collections/Podspecs
end

# end
