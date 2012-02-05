//
//  COSHighScoreView.m
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSHighScoreView.h"
#import "COSHighScoreTable.h"
#import "HighScoreKeeper.h"
#import "COSConstants.h"

@implementation COSHighScoreView


- (void) dealloc {
  [personalScoresTable release];
  [overallScoresTable release];
  [super dealloc];
}



- (id) init {
  self = [super init];
  HighScoreKeeper *hsk = [HighScoreKeeper sharedInstance];
  personalScoresTable = [[COSHighScoreTable alloc]initWithScoreList:[hsk scoresForLastPlayer]
                                                              frame:CGRectZero showName:NO];
  overallScoresTable = [[COSHighScoreTable alloc]initWithScoreList:[hsk sortedScores]
                                                             frame:CGRectZero showName:YES];
  return self;
}


- (void) loadView {
  self.view = [[[UIView alloc]initWithFrame:[[[[UIApplication sharedApplication] delegate] window] frame]]autorelease];

  CGRect yourScoresLabelFrame = CGRectMake(PADDING/2, 
                                           PADDING/2, 
                                           self.view.frame.size.width-PADDING, 
                                           35);
  UILabel *yourScoresLabel = [self labelWithFrame:yourScoresLabelFrame 
                                             text:@"Your Best Scores" 
                                             font:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
  
  personalScoresTable.frame = CGRectMake(0, 
                                         yourScoresLabelFrame.size.height+yourScoresLabelFrame.origin.y, 
                                         self.view.frame.size.width, 
                                         200);
  
  CGRect scoresLabelFrame = CGRectMake(PADDING/2, 
                                       personalScoresTable.frame.origin.y+personalScoresTable.frame.size.height, 
                                       self.view.frame.size.width-PADDING, 
                                       35);
  UILabel *scoresLabel = [self labelWithFrame:scoresLabelFrame 
                                         text:@"Overall Best Scores" 
                                         font:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
  
  overallScoresTable.frame = CGRectMake(0, 
                                        scoresLabelFrame.origin.y+scoresLabelFrame.size.height, 
                                        self.view.frame.size.width, 
                                        200);

  [self.view addSubview:yourScoresLabel];
  [self.view addSubview:scoresLabel];
  [self.view addSubview:personalScoresTable];
  [self.view addSubview:overallScoresTable];
}


@end
