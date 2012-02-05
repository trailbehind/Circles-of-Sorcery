//
//  HighScoreKeeper.h
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScoreKeeper : NSObject {
  
  NSMutableArray *highScores;
  NSString *lastPlayerName;
}

@property(nonatomic, retain) NSString *lastPlayerName;


+ (HighScoreKeeper*)sharedInstance;
- (NSArray*) scoresForLastPlayer;
- (NSArray*) sortedScores;
- (void) setHighScore:(int)score forPlayerName:(NSString*)playerName;

@end
