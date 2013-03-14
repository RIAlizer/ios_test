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

### Demo App
* You can install a working demo from [here](http://lab.joinpad.net/rializer/yk/latest) (Enterprise Distribution)



### Compatibility
* iOs Deployment Target iOS 5.1
* iPhone - iPad

### Features
* Simple UI enhancement
* Infinite scrolling for TableView pagination	
* Pull-to-refresh in TableView header
* Very simple Pie Chart implementation in YKGraphView
* Works automagically on ARC and non-ARC enviroment - more info [Utils/DevDefines.h](https://github.com/RIAlizer/ios_test/blob/master/project/YakimbiIosTest/YakimbiIosTest/Utils/DevDefines.h "DevDefines.h")  
	* Target YKFileManager for non-ARC
	* Target YKFileManagerARC is ARC enabled

	
	
 


### Dependencies
Dependencies are managed using  [**CocoaPods**](http://www.cocoapods.org).  
** In order to compile sources you must open __YakimbiIosTest.xcworkspace__ **.  
All these libraries are essential for advanced iOS development.

* [**InAppSettingsKit**](https://github.com/futuretap/InAppSettingsKit) is an open source solution to to easily add in-app settings to your iPhone apps.  
 *pod 'InAppSettingsKit', '~> 1.0' *

* [**DCIntrospect**](https://github.com/domesticcatsoftware/DCIntrospect) is small set of tools for iOS that aid in debugging user interfaces built with UIKit. It's especially useful for UI layouts that are dynamically created or can change during runtime, or for tuning performance by finding non-opaque views or views that are re-drawing unnecessarily. It's designed for use in the iPhone simulator, but can also be used on a device.  
*pod 'DCIntrospect', '~> 0.0.2' *

* [**ISO8601DateFormatter**](https://bitbucket.org/boredzo/iso-8601-parser-unparser/) is a standard Date formatter  
 *pod 'ISO8601DateFormatter', '~> 0.6' * 




