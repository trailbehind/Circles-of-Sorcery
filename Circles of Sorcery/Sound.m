//
//  Sound.m
//  TrailBehind
//

#import "Sound.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
@implementation Sound


+ (void) setUpSession {
  [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
  UInt32 doSetProperty = 1;
  AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof(doSetProperty), &doSetProperty);
  [[AVAudioSession sharedInstance] setActive: YES error: nil];
}


// set up our standard audio player to be used with various sounds
+ (AVAudioPlayer*) getAudioPlayer: (NSString*)sndPath{
  NSURL *url = [NSURL fileURLWithPath:sndPath];
	AVAudioPlayer *ap = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                             error:NULL];
	ap.numberOfLoops = 0;
	ap.volume = 0.05f;
	return [ap autorelease];
}


  

// returns the path to a given sound filename of type .wav
+ (NSString*) soundpath:(NSString*)filename {
  return [[NSBundle mainBundle]
          pathForResource:filename
          ofType:@"wav"
          inDirectory:@""];
}


+ (void) playSuccessSound {
  static AVAudioPlayer* slidePlayer;
  if (!slidePlayer) {
    slidePlayer = [Sound getAudioPlayer:[Sound soundpath:@"success"]];  
    slidePlayer.volume = .25;
    [slidePlayer retain];
  }
  [slidePlayer play];
}


+ (void) playRequestSound {
  static AVAudioPlayer* requestPlayer;
  if (!requestPlayer) {
    requestPlayer = [Sound getAudioPlayer:[Sound soundpath:@"request"]];  
    requestPlayer.volume = .5;
    [requestPlayer retain];
  }
  [requestPlayer play];
}

+ (void) playDistanceChime {
  static AVAudioPlayer* chimePlayer;
  if (!chimePlayer) {
    chimePlayer = [Sound getAudioPlayer:[Sound soundpath:@"chime3"]];  
    chimePlayer.volume = 1;
    [chimePlayer retain];
  }
  [chimePlayer play];
}


// sets up the Audio session so it won't turn off the user's music when a sound is played
+ (void) mergeSoundsWithiPod {
  //[[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
  //UInt32 doSetProperty = 1;
  //AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof(doSetProperty), &doSetProperty);
  //[[AVAudioSession sharedInstance] setActive: YES error: nil];
}


@end