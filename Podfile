platform :ios, '11.0'

target 'CatVoter' do
  use_frameworks!

  pod 'SVProgressHUD'
  pod 'SwiftLint'


  target 'CatVoterTests' do
    inherit! :search_paths
    pod 'Sourcery'
  end

end

target 'TheCatsAPI' do
  use_frameworks!

  target 'TheCatsAPITests' do
    inherit! :search_paths

    pod 'OHHTTPStubs/Swift'
    pod 'Sourcery'
  end

end
