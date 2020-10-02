# platform :ios, '13.6'

target 'Stock portfolio' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Stock portfolio

  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Database'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
end
