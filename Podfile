platform :ios, '9.0'

workspace 'WatchCon.xcworkspace'

target 'WatchCon-iOS' do
	platform :ios, '9.0'
	project 'WatchCon.xcodeproj'
	use_frameworks!

  target 'WatchCon-iOSTests' do
    inherit! :search_paths
    pod 'OCMock', '~> 3.4'
    pod 'Quick', '~> 1.1'
    pod 'Expecta', '~> 1.0'
  end

end

def product_pods
	pod 'WatchCon', :path => '.'
end

target 'WatchOS-Sample' do
	project 'Sample/WatchOS-Sample/WatchOS-Sample.xcodeproj'
	use_frameworks!
    inherit! :search_paths
    product_pods
end
