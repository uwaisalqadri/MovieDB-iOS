# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'

def general_pod
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'RealmSwift'
  pod 'ObjectMapper', '~> 4.2.0'
  pod "ObjectMapper+Realm"
  pod 'Moya'

end

def ui_pod
  pod 'SDWebImage'
  pod 'SVProgressHUD'
  pod 'PinLayout'
  pod 'Reusable'
end


target 'MuviApp-IOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MuviApp-IOS
  general_pod
  ui_pod

end
