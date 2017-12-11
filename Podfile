# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def pod_list
    pod 'SDWebImage/Core'
    pod 'DTCoreText', '~> 1.6'
end

target 'FlickrImageViewer' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

    pod_list
  # Pods for FlickrImageViewer

  target 'FlickrImageViewerTests' do
    inherit! :search_paths
    # Pods for testing
    pod_list
  end

  target 'FlickrImageViewerUITests' do
    inherit! :search_paths
    # Pods for testing
    pod_list
  end

end
