//
//  COSTurnCounter.m
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSTurnCounter.h"
#import "COSConstants.h"
#import "ScoreTable.h"
#import "COSPlayer.h"
#import "COSPlayerArea.h"


@implementation COSTurnCounter

- (void) dealloc {
  [counterLabel release];
  [player release];
  [super dealloc];
}


- (void) incrementCounter {
  turnCount++;
  counterLabel.text = [NSString stringWithFormat:@"%d/%d", turnCount, NUMBER_OF_TURNS];
}


- (int) turnCount {
  return turnCount;
}


- (void) showTurnTable {
  UIViewController *vc = [[[UIViewController alloc]init]autorelease];
  ScoreTable *table = [[[ScoreTable alloc]initWithScoreKeeper:player.scoreKeeper]autorelease];
  vc.view = table;
  UIPopoverController *pop = [[UIPopoverController alloc]initWithContentViewController:vc];
  [pop presentPopoverFromRect:CGRectMake(player.playerArea.frame.size.width/2, 0, 1, 1) inView:player.playerArea permittedArrowDirections:0 animated:YES];

}


- (id)initWithFrame:(CGRect)frame player:(COSPlayer*)p {
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 80, 70)];
    if (self) {
      player = [p retain];
      turnCount = 0;
      CGRect labelFrame = CGRectMake(0, 0, self.frame.size.width, 20);
      UILabel *label = [[[UILabel alloc]initWithFrame:labelFrame]autorelease];
      label.text = @"Turn";
      label.backgroundColor = [UIColor clearColor];
      label.textAlignment = UITextAlignmentCenter;
      [self addSubview:label];
      
      labelFrame.origin.y = 20;
      counterLabel = [[UILabel alloc]initWithFrame:labelFrame];
      counterLabel.backgroundColor = [UIColor clearColor];
      counterLabel.textAlignment = UITextAlignmentCenter;
      [self addSubview:counterLabel];
      [self incrementCounter];
      CGRect buttonFrame = CGRectMake(PADDING, 50, self.frame.size.width-PADDING*2, 30);
      UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
      button.frame = buttonFrame;
      [button addTarget:self 
                 action:@selector(showTurnTable) 
       forControlEvents:UIControlEventTouchUpInside];
      [button setTitle:@"Turns" forState:UIControlStateNormal];
      [self addSubview:button];
            
    }
    return self;
}


@end
