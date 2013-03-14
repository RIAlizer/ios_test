## Description

Universal Application that runs on both iPad and iPhone.

Get Json File from web url https://gist.github.com/raw/4680060/aac6d818e7103edfe721e719b1512f707bcfb478/sample.json,
save revision number.
If data is more than 20 record than show data in pages (page =data/20).
Save data in Core Data Entities
Retrieve Data from Core Data and display in Custom Table view with Custom cell displaying all values of tab view.
Fetch data from core data without fetch using properties.(use Fetech Request , predicate and EntityDescription )

When you click on table view cell. Open pop over view controller with uitableview and some sample value like Row 1, Row 2, Row 3


## Rules

* fork this repo to your github account
* use Async downloading and at any point UI should not been blocked.
* do not use any open source frameworks, only use native frameworks available
* For Json Managment you can use JSON Parser 
* push the code on your Github account and make a pull request to YakimbiICT/ios_test
* **IF YOU CAN'T USE A PUBLIC REPO ON GITHUB, USE BITCUCKET [[ https://bitbucket.org/ ]] AND SET UP A PRIVATE REPO**

## Bonus points
* Add branches for both ARC and non-ARC implementations.
* Add unit or/and functional tests


--------

## DEVELOPMENT

### Compatibility
* iOs Deplyment Target iOS 5.0
* iPhone / iPad
* works automagically on ARC and non-ARC enviroment (more info @ Utils/Define.h )



### Dependencies
Dependencies are managed using **CocoaPods** (www.cocoapods.org).  
In order to compile sources you must open **YakimbiIosTest.xcworkspace**.  
All these libraries are essential for advanced iOS development.

* **InAppSettingsKit** is an open source solution to to easily add in-app settings to your iPhone apps.  
 *pod 'InAppSettingsKit', '~> 1.0' https://github.com/futuretap/InAppSettingsKit*

* **DCIntrospect** is small set of tools for iOS that aid in debugging user interfaces built with UIKit. It's especially useful for UI layouts that are dynamically created or can change during runtime, or for tuning performance by finding non-opaque views or views that are re-drawing unnecessarily. It's designed for use in the iPhone simulator, but can also be used on a device.  
*pod 'DCIntrospect', '~> 0.0.2' https://github.com/domesticcatsoftware/DCIntrospect*

* **ISO8601DateFormatter** is a standard Date formatter  
 *pod 'ISO8601DateFormatter', '~> 0.6' https://bitbucket.org/boredzo/iso-8601-parser-unparser/* 




