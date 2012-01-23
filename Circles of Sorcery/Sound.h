//
//  Sound.h
//  Trailbehind
//
// Convenience class to handle playing sounds

#import <Foundation/Foundation.h>

@interface Sound : NSObject {
  
}

+ (void) playSuccessSound;
+ (void) playRequestSound;
+ (void) playDistanceChime;
+ (void) mergeSoundsWithiPod;
+ (void) setUpSession;

@end
