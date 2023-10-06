# SwiftyAuthentication

[![CI Status](https://img.shields.io/travis/DeveloperZainModr/SwiftyAuthentication.svg?style=flat)](https://travis-ci.org/DeveloperZainModr/SwiftyAuthentication)
[![Version](https://img.shields.io/cocoapods/v/SwiftyAuthentication.svg?style=flat)](https://cocoapods.org/pods/SwiftyAuthentication)
[![License](https://img.shields.io/cocoapods/l/SwiftyAuthentication.svg?style=flat)](https://cocoapods.org/pods/SwiftyAuthentication)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyAuthentication.svg?style=flat)](https://cocoapods.org/pods/SwiftyAuthentication)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* Xcode 12.x
* Swift 5.x
* IOS 13.0+

## Installation
SwiftyAuthentication does not contain any dependency.
These are the currently supported installation options:

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

## Cocoapod
SwiftyAuthentication is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftyAuthentication'
```
Open terminal in your project directory and type:

```bash
$ pod install
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)
Add this URL to your package manager.

```ruby
https://github.com/ZainMobe/SwiftyAuthentication.git
```

## Usage

```swift
let service = SwiftyAuthentication()
service.signInWithApple([.fullName, .email]) { result in
            switch result {
                case .success(let user):
                    print("User: ", user)
                    
                case .failure(let error):
                    print("Error: ", error.localizedDescription)
            }
        }
```

## Author

Zain Haider, zainpk121@icloud.com

## License

SwiftyAuthentication is available under the MIT license. See the LICENSE file for more info.
