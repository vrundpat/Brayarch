# Brayarch Statistics
A Destiny 2 stat tracker iOS application made using Swift, UIKit, and Cocoapods with programmatic UI.

Note: Due to the conversion of the previously `.mp4` files to `.gif`, there is some noticable frame and quality loss

## App Preview

|Home Page                  |  Base Statistics Page     |  Activity History Page    |  Carnage Report Page      | 
|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
<img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/homescreen1.dataset/homescreen1.gif" >  |  <img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/statscreen1.dataset/statscreen1.gif" >  | <img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/activityscreen1.dataset/activityscreen1.gif" > | <img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/carnagereportscreen1.dataset/carnagereportscreen1.gif" > |


## Some Other Carnage Reports 
|Raid/Dungeon Carnage Reports|Iron Banner Carnage Reports|Trials of Osiris Carnage Reports|Vanguard/Strike Reports| 
|:-------------------------:  |:-------------------------:|:-------------------------:|:-------------------------:|
<img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/dungeoncarnagereport.imageset/dungeoncarnagereport.png" >  | <img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/ironbannercarnagereport.imageset/ironbannercarnagereport.png" >       |<img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/trialscarnagereport.imageset/trialscarnagereport.png" >       |<img src="https://github.com/vrundpat/BrayarchStatistics/blob/master/StatTracker/Assets.xcassets/strikecarnagereport.imageset/strikecarnagereport.png" >        |


## Running this Project
##### Note: Cocoapods is required to run this project.
Recommended IDE: Xcode
##### In your preferred Terminal / Command-line interface, navigate to the cloned project's root and execute: `pod init`
##### Now you should have a file named `Podfile` in the directory. Next, execute `nano Podfile`
##### Under `# Pods for StatTracker`, paste the following:
  `pod 'NVActivityIndicatorView'`<br/>
    `pod 'Charts'`
##### Press the following in the given order: `control + X`, `Y` and `Enter`
##### Finally, execute `pod install` in the project directory
##### Now, a file by the name of `StatTracker.xcworkspace` should be present
##### Open `StatTracker.xcworkspace` and run the project!
