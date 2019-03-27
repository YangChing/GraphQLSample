# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GraphQLSample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GraphQLSample

  target 'GraphQLSampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  pod 'Apollo', :git => 'https://github.com/apollographql/apollo-ios.git', :branch => 'master'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxApolloClient'
  pod 'RxOptional'
  pod 'FLEX', '~> 2.0', :configurations => ['Debug']
end
