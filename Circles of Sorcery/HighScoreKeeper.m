//
//  HighScoreKeeper.m
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HighScoreKeeper.h"
#import "COSConstants.h"

@implementation HighScoreKeeper
@synthesize lastPlayerName;

- (void) dealloc {
  [highScores release];
  [lastPlayerName release];
  [super dealloc];
}


- (NSString*) highScoresFilePath {
  return [documentsDirectory() stringByAppendingString: @"/highScores.txt"];
}  


- (void) initHighScoresFromDisk {
  NSString *path = [self highScoresFilePath];
  if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
    highScores  = [[NSMutableArray arrayWithContentsOfFile:path]retain];
  } else {
    highScores = [[NSMutableArray alloc]init];
  }
}


+ (HighScoreKeeper*)sharedInstance {
  static HighScoreKeeper *sharedInstance = nil;
  @synchronized(self) {
    if (sharedInstance == nil) {
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
      sharedInstance = [[HighScoreKeeper alloc] init];
      [sharedInstance initHighScoresFromDisk];
      sharedInstance.lastPlayerName = nil;
			[pool release];
    }
  }
  return sharedInstance;
}


- (NSArray*) sortedScores {  
  NSSortDescriptor* sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"amount" 
                                                                 ascending:NO]autorelease];
  NSLog(@"The sorted Scores are %@", [highScores sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]);
  return (NSArray*)[highScores sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}


- (NSArray*) scoresForLastPlayer {  
  NSMutableArray *playerScores = [NSMutableArray array];
  for (NSDictionary *scoreDict in highScores) {
    if ([[scoreDict objectForKey:@"name"]isEqualToString:lastPlayerName]) {
      [playerScores addObject:scoreDict];
    }
  }
  NSSortDescriptor* sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"amount" 
                                                                  ascending:NO]autorelease];
  NSLog(@"The scores for last player are %@", [playerScores sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]);

  return (NSArray*)[playerScores sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}


- (void) saveToDisk {
  [highScores writeToFile:[self highScoresFilePath] atomically:NO];
}


- (int) getScoreIndex:(int)amount {
  int x = 0;
  for (NSDictionary *score in [self sortedScores]) {
    if (amount >= [[score objectForKey:@"amount"]intValue]) {
      return x;
    }
    x++;
  }
  return 0;
}


- (void) setHighScore:(int)score forPlayerName:(NSString*)playerName {
  NSNumber *scoreNum = [NSNumber numberWithInt:score];
  NSDictionary *newScoreDict = [NSDictionary dictionaryWithObjectsAndKeys: playerName, @"name", 
                                scoreNum, @"amount",  nil];
  [highScores addObject:newScoreDict];
  [self saveToDisk];
}

@end
