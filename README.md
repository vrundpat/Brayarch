# Brayarch Statistics
A Destiny 2 stat tracker iOS application made using Swift, UIKit, and Cocoapods with programmatic UI.

[![Language](https://img.shields.io/badge/Language-Swift-blue)](https://shields.io/) 
[![UI](https://img.shields.io/badge/UI-Programmatic-blue)](https://shields.io/)
[![Package Manager](https://img.shields.io/badge/Package%20Manager-Cocoapods-pink)](https://shields.io/)
[![Version](https://img.shields.io/badge/Version-1.0.0-green)]()
[![Release](https://img.shields.io/badge/Release-In%20Progress-orange)]()

## App Preview

|Home Page                  |  Base Statistics Page     |  Activity History Page    |  Carnage Report Page      | 
|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
<img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/homescreen1.dataset/homescreen1.gif" >  |  <img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/statscreen1.dataset/statscreen1.gif" >  | <img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/activityscreen1.dataset/activityscreen1.gif" > | <img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/carnagereportscreen1.dataset/carnagereportscreen1.gif" > |


## Some Other Carnage Reports 
|Raid/Dungeon Carnage Reports|Iron Banner Carnage Reports|Trials of Osiris Carnage Reports|Vanguard/Strike Reports| 
|:-------------------------:  |:-------------------------:|:-------------------------:|:-------------------------:|
<img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/dungeoncarnagereport.imageset/dungeoncarnagereport.png" >  | <img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/ironbannercarnagereport.imageset/ironbannercarnagereport.png" >       |<img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/trialscarnagereport.imageset/trialscarnagereport.png" >       |<img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/strikecarnagereport.imageset/strikecarnagereport.png" >        |


## Running Brayarch
### Cocoapods is required to run this project.

#### In the project root, run the following commands:
```bash 
 `pod init`
 ```
 
 ####  Now you should have a file named `Podfile` in the directory. Open the Podfile and paste the following:
 ```bash
    pod 'NVActivityIndicatorView'
    pod 'Charts'
 ```
 
Then, install the pulled libraries via:
```baah
  pod install
```

Now, a file by the name of `StatTracker.xcworkspace` should be present <br/>
Open `StatTracker.xcworkspace` and run the project!
