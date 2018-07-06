Table of Contents
-----------------
My First Project!
"If you don't know were to go, go WhereIs."
* - [Overview & Features](#overview--features)
* - [Prerequisites](#prerequisites)
* - [Endpoints Foursquare API](#endpoints-foursquare-api)
* - [Project Structure](#project-structure)
* - [Workspace Preparing](#workspace-preparing)
* - [Deployment to iOS device](#deployment-to-ios-device)
* - [Obtaining the Defines](#obtaining-the-defines)
* - [List of Frameworks](#list-of-frameworks)
* - [Useful Tools and Resources](#useful-tools-and-resources) <!-- - [FAQ](#faq) -->
* - [License](#license) 

## Overview & Features

WhereIs is an app that lets you search and browse for nearby venues.
1. Use FourSquare API to access venues
* User can search by location 
* User can search by category
* User can search by query e.g Coffee 
* Reload venue depends on location from center of screen
* Toggle between a map view of venues and a list view of venues
2. Integrate MapKit to show live updates on map based on search results 
* Annotations update on map
* Details about the venue on Annotations 
* Directions to selected venue using apple maps
3. Use CoreLocation to track user's Location 
* Authorization to allow location services 
4. Display detailed information about certain venues 
* Images of venues
* Adress/likes/ratings/distance/checkin of venues
* Directions to venue 
* Tips of venue 
5. Custom Venue Favorite
* Users can create favorite of certain venues to view again later ( can delete any venue or all list )
6. Option searching of venue
* Users can Option more when searching ( Radius, Limit and City of venue)

## Prerequisites

- [MacOS Sierra (10.12.x)](https://www.apple.com/lae/macos/sierra/)
- [Xcode 8.3.x](https://developer.apple.com/download/) ~ Swift 3.1
- [CocoaPods 1.2.x](https://cocoapods.org/#install)

## Endpoints Foursquare API

Foursquare is a local search-and-discovery service helps you find the perfect places to go with friends. Discover the best food, nightlife, and entertainment in your area.
The Foursquare API provides location based experiences with diverse information about venues, users, photos, and check-ins. The API supports real time access to places, Snap-to-Place that assigns users to specific locations, and Geo-tag. Additionally, Foursquare allows developers to build audience segments for analysis and measurement. JSON is the preferred response format.

Venue Search: GET https://api.foursquare.com/v2/venues/search
Venue Photos: GET https://api.foursquare.com/v2/venues/VENUE_ID/photos
Venue Details : GET https://api.foursquare.com/v2/venues/VENUE_ID
Venue Tips :     GET https://api.foursquare.com/v2/venues/VENUE_ID/tips


## Project Structure

| Name | Description |
| --- | --- |
| **Define**/ | The most time static values will be put here, such as third party keys, colors, fonts... |
| **Define**/Key.swift | Third party keys/credientials will be defined here |
| **Define**/String.swift | Localizable strings will be defined here |
| **Define**/Color.swift | Colors will be defined here |
| **Define**/Font.swift | Fonts will be defined here |
| **View**/ | Everything relative directly to UI |
| **View**/Base/ | Base classes for view controller, popup controller... |
| **View**/Controls/ | Custom controls: label, button, cell... |
| **View**/Controllers/ | View controllers |
| **ViewModel**/ | Data holding & logic handling for view controller |
| **Model**/ | Business objects and business logic will be put here |
| **Model**/API/ | API request will be handled here |
| **Model**/Schema/ | ORM objects will be defined here |
| **Library**/ | Helper, Utils, Extension... or frameworks which cannot be put in CocoaPods (ex: modified, no podspec found...) |
| **Resources**/ | Image, video, audio, font, `Localizable.strings`... |
| **Supports**/ | Application info, target configuration, bridging... |

**Note:** You should place your controllers in `Controllers` directory with a nested folder structure.

## Workspace Preparing

- `./scripts/install` - this script will install
- [brew](https://github.com/Homebrew/brew) command & necessary formulas
- [rbenv](https://github.com/rbenv/rbenv) command & necessary gems
- [pod](https://cocoapods.org/) command & project's dependences

- `open *.xcw*` - this command will open generated workspace with Xcode.

### Installation manual

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

```sh
sudo gem install cocoapods
```

```sh
gem install bundler
bundle install
bundle exec pod install --repo-update
```

## Deployment to iOS device

It is possible to sideload this project app into your iOS device by following these instructions :

* Open the MyApp project and open the file that says “MyApp.xcworkspace“.

* Xcode will load the project for you. Click on “MyApp” in the left sidebar.

* You’ll need to change a couple of settings in order to install the app on your iPhone. First, go to “Xcode -> Preferences“, and click on the “Accounts” tab. You’ll have to add your Apple ID here. You can simply click on the plus icon in the bottom of the screen and add your Apple ID. It doesn’t need to be a developer ID, you can use your free Apple ID, as well.

* Once you have done that, you will need to change a couple of settings for the Xcode project. Firstly, change the value next to “Bundle Identifier“, and make it anything that is unique, and looks like com.hien.WhereIs. In my case, I’ve replaced “hien” with my name.

* Next, you’ll have to add a “development team” for the project. Simply click on the drop down box next to “Development Team”, and select “Your Name (personal team)“.

* You’re all set to install Discover Venue on your iPhone. Simply connect your iPhone to your Mac. Then, go to “Product -> Destination“, and select your iPhone from the list.

* Now, click on the “Run” button in Xcode. Xcode will then begin compiling the app for your iPhone. If you get warnings (yellow triangle signs), don’t worry about them.

* Xcode will prompt you with an error saying that you need to trust the developer on the iPhone. On your iPhone, go to “Settings -> General -> Profiles and Device Management“.

* Tap on the entry under “Developer App”, and tap on “Trust”.

* You can now go to your homescreen, and look for WhereIs. Tap on the app to launch it.  Allow location services. WhereIs is ready to use!

## Obtaining the Defines

To use any of the included APIs or third parties, you will need to obtain appropriate credentials: Client ID, Client Secret, API Key, or Username & Password... You will need to go through each provider to generate new credentials.

> Don't forget to update all API keys with *your credentials* when you are ready to deploy an app.

## List of Frameworks

| Framework | Description |
| ------------------------------- | --------------------------------------------------------------------- |
| MVVM-Swift | MVVM Architect for iOS Application. |
| SVProgressHUD | A clean and lightweight progress HUD for your iOS and tvOS app. |
| IQKeyboardManagerSwift | Codeless drop-in universal library allows to prevent issues of keyboard sliding up and cover UITextField/UITextView. Neither need to write any code nor any setup required and much more. |
| LGSideMenuController | iOS view controller, shows left and right views by pressing button or gesture. |
| RealmS | Realm + ObjectMapper. |
| ObjectMapper | Simple JSON Object mapping written in Swift. Please fix this version to 2.2.6 now. |
| SwiftyJSON | The better way to deal with JSON data in Swift. |
| Alamofire | Elegant HTTP Networking in Swift. |
| AlamofireNetworkActivityIndicator | Controls the visibility of the network activity indicator on iOS using Alamofire. |
| SwifterSwift | SwifterSwift is a library of over 500 properties and methods, designed to extend Swift's functionality and productivity, staying faithful to the original API design guidelines of Swift 3.. |
| SwiftDate | The best way to manage Dates and Timezones in Swift. |
| SDWebImage | This library provides an async image downloader with cache support. |
| PageMenu | Paging through view controllers made easy. |
| SAMKeychain | Simple Objective-C wrapper for the keychain that works on Mac and iOS. |
| KeychainAccess | ESimple Swift wrapper for Keychain that works on iOS, watchOS, tvOS and macOS. |
| SwiftLint | A tool to enforce Swift style and conventions. |
| AsyncSwift | Syntactic sugar in Swift for asynchronous dispatches in Grand Central Dispatch. |
| SwiftUtils | Swift shorthand. |
| SwiftyUserDefaults | Modern Swift API for NSUserDefaults. |
| DeviceKit | DeviceKit is a value-type replacement of UIDevice. |
| Fabric/Crashlytics | Crash reporting & beta deployment. |

## Useful Tools and Resources

- [CocoaPods](https://cocoapods.org/) - CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. It has over 33 thousand libraries and is used in over 2.2 million apps. CocoaPods can help you scale your projects elegantly.
- [fastlane](https://docs.fastlane.tools/) - The easiest way to automate building and releasing your iOS and Android apps.
- [Swimat](https://github.com/Jintin/Swimat) - An Xcode formatter plug-in to format your Swift code.
- [SwiftLint](https://github.com/realm/SwiftLint) - A tool to enforce Swift style and conventions.
- [Ray Wenderlich](https://www.raywenderlich.com/) - The largest collection of Swift & iOS video tutorials anywhere.
- [design+code](https://designcode.io/iosdesign-guidelines) - iOS 10 Design Guidelines for iPhone and iPad.
- [Fabric](https://docs.fabric.io/apple/fabric/overview.html) - Fabric is a platform that helps your mobile team build better apps, understand your users, and grow your business.
- [TestFlight](https://help.apple.com/itunes-connect/developer/#/devdc42b26b8) - TestFlight beta testing lets you distribute beta builds of your app to testers and collect feedback.
- [DeployGate](https://deploygate.com/docs/ios_sdk?locale=en) - DeployGate makes it easy to share your in-development iOS and Android apps, allowing developers to seamlessly progress through the prototyping, development, testing, and marketing stages of app distribution.

## License

Copyright (c) 2018 Hien Nguyen  zduchien@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
