#
# Be sure to run `pod lib lint SwiftyAuthentication.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyAuthentication'
  s.version          = '0.1.0'
  s.summary          = 'SwiftyAuthentication is a single-line sign-in with Apple service.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'When you sign in with Apple, you typically receive the user's information, such as their name and email, only for the first login. However, by using SwiftyAuthentication, you can obtain the user's information every time you sign in with Apple. SwiftyAuthentication securely stores the user's information in the keychain and retrieves it from there.'
                       DESC

  s.homepage         = 'https://github.com/ZainMobe/SwiftyAuthentication'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DeveloperZainModr' => 'zainpk121@icloud.com' }
  s.source           = { :git => 'https://github.com/ZainMobe/SwiftyAuthentication.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://medium.com/@developerzain'

  s.ios.deployment_target = '13.0'
  

  s.source_files = 'Source/**/*.swift'
  s.swift_version = '5.0'
  s.platforms = {
      "ios": "13.0"
  }
end
