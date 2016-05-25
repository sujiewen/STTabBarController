Pod::Spec.new do |s|
s.name             = "STTabBarController"
s.version          = "0.1.4"
s.summary          = "Sjw Testing."
s.description      = <<-DESC
Testing public Podspec.

* Markdown format.
* Don't worry about the indent, we strip it!
DESC
s.homepage         = "https://github.com/lovesunstar/STKit"
s.license          =  { :type => 'MIT', :file => 'LICENSE.txt' }
s.author           = { "sujiewen" => "sujiewen@qq.com" }
s.source           = { :git => "https://github.com/sujiewen/STTabBarController.git", :tag => "0.1.4" }
# s.social_media_url = 'https://github.com/lovesunstar/STKit'
s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'STTabBarController/**/*','STTabBarController/STNavigation/*','STTabBarController/STTabBar/*'

s.public_header_files = 'STTabBarController/**/*.h','STTabBarController/STNavigation/*.h','STTabBarController/STTabBar/*.h'
s.frameworks = 'UIKit','Foundation'
end