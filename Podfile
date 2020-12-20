# Uncomment the next line to define a global platform for your project
minimum_deployment_target = '11.0'
platform :ios, minimum_deployment_target

target 'iTunes' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iTunes
  pod 'Alamofire'
  pod 'Kingfisher'

  target 'iTunesTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iTunesUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = minimum_deployment_target
    end
  end
end
