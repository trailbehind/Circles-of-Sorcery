//
//  COSScoreView.m
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSScoreView.h"
#import "COSScoreKeeper.h"
#import "ScoreTable.h"
#import "HighScoreKeeper.h"
#import "COSConstants.h"
#import "COSPlayerArea.h"
#import "COSPlayer.h"

@implementation COSScoreView

- (void) dealloc {
  [scoreKeeper release];
  [scoreTable release];
  [highScoreNameField release];
  [super dealloc];
}


- (id) initWithScoreKeeper:(COSScoreKeeper*)keeper {
  self = [super init];
  scoreKeeper = [keeper retain];
  scoreTable = [[ScoreTable alloc]initWithScoreKeeper:scoreKeeper];
  return self;
}

- (int) highScore {
  return [[[[scoreKeeper scores]objectForKey:@"reward"]objectForKey:@"total"]intValue];
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
  if (!highScoreNameField.text 
      || [highScoreNameField.text isEqualToString:@""]) {
    return YES;
  }
  
  [[HighScoreKeeper sharedInstance]setLastPlayerName:highScoreNameField.text];
  [[HighScoreKeeper sharedInstance]setHighScore:[self highScore] 
                                  forPlayerName:highScoreNameField.text];
  [scoreKeeper scoreEntered];
  return YES;
}


- (UILabel*) labelWithFrame:(CGRect)frame text:(NSString*)text font:(UIFont*)font {
  UILabel *label = [[[UILabel alloc]initWithFrame:frame]autorelease];
  label.text = [NSString stringWithFormat:text];
  label.font = font;
  label.backgroundColor = [UIColor clearColor];
  label.textColor = [UIColor whiteColor];
  label.shadowColor = [UIColor blackColor];
  label.textAlignment = UITextAlignmentCenter;
  label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  return label;
}

- (void) loadView {
  [super loadView];  
  
  
  CGRect greatGameLabelFrame = CGRectMake(PADDING/2, 
                                          PADDING/2, 
                                          self.view.frame.size.width-PADDING, 
                                          22);
  UILabel *greatGameLabel = [self labelWithFrame:greatGameLabelFrame 
                                            text:@"Great Game" 
                                            font:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
  [self.view addSubview:greatGameLabel];
  
  
  CGRect scoreLabelFrame = CGRectMake(PADDING/2, 
                                      PADDING+22, 
                                      self.view.frame.size.width-PADDING, 
                                      45);
  UILabel *scoreLabel = [self labelWithFrame:scoreLabelFrame 
                                        text:[NSString stringWithFormat:@"%d points - that's a new high score!", [self highScore]]
                                        font:[UIFont fontWithName:@"Helvetica" size:16]];
  [self.view addSubview:scoreLabel];
  
  
  highScoreNameField = [[[UITextField alloc]initWithFrame:CGRectMake(PADDING/2, 
                                                                     PADDING+22+45+PADDING/2, 
                                                                     self.view.frame.size.width-PADDING, 
                                                                     25)] autorelease];
  highScoreNameField.borderStyle = UITextBorderStyleRoundedRect;
  highScoreNameField.delegate = self;
  highScoreNameField.placeholder = @"Enter your name to see how you rank";
  highScoreNameField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:highScoreNameField];
  NSString *lastPlayerName = [[HighScoreKeeper sharedInstance]lastPlayerName];
  highScoreNameField.text = lastPlayerName;
  
  CGRect gameSummaryLabelFrame = CGRectMake(PADDING/2, 
                                            PADDING+22+45+PADDING+25+20, 
                                            self.view.frame.size.width-PADDING, 
                                            22);        
	UILabel *gameSummaryLabel = [self labelWithFrame:gameSummaryLabelFrame 
                                              text:@"Game Summary" 
                                              font:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
  [self.view addSubview:gameSummaryLabel];
  
  float yOffset = gameSummaryLabelFrame.size.height+gameSummaryLabelFrame.origin.y+PADDING;
  scoreTable.frame = CGRectMake(0, 
                                yOffset, 
                                self.view.frame.size.width, 
                                self.view.frame.size.height-yOffset-10);
  scoreTable.sectionHeaderHeight = 30;
  [self.view addSubview:scoreTable];
  [scoreTable reloadData];
  
}




@end
