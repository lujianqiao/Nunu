# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'


target 'Nunu' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Nunu

  pod 'Alamofire'
  pod 'Moya'
  pod 'SnapKit'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'TZImagePickerController'
  pod 'JXBanner'
  # 自动管理键盘
  pod 'IQKeyboardManagerSwift', '6.2.1'
  
  pod 'HandyJSON', '~> 5.0.2'

  target 'NunuTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NunuUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
