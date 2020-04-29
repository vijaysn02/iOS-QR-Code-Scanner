# QR Code Scanner

## Introduction:

This project is created to understand the working of AV player and also to have a ready made component for integration in the projects.

----------------------------------------------------------------------------------------------------

## Installation:

You dont need a special installation of any cocopods for this. You can use AVKit provided by Apple.


----------------------------------------------------------------------------------------------------

## Configuration:

No specific Configuration needed.

----------------------------------------------------------------------------------------------------

## Coding Part - Handler:


### 

```
    class MediaPlayer {
        
        static func openMedia(url:String,viewController:UIViewController) {
            
            guard let videoURL = URL(string: url) else {
                return
            }
            
            let player = AVPlayer(url: videoURL)
            
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player

            viewController.present(playerViewController, animated: true) {
              player.play()
            }
        }
        
    }
```

----------------------------------------------------------------------------------------------------

## Usage Part

### Invoke this specific function to use in your View Controller

```
    MediaPlayer.openMedia(url:videoURLString,viewController:self)
```
