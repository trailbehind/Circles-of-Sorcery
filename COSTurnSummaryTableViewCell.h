//
//  COSTurnSummaryTableViewCell.h
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COSTurnSummaryTableViewCell : UITableViewCell {
  UILabel *turnNumberLabel, *pointsLabel, *cardsLabel, *goldLabel;
  UIImageView *pointsIcon, *cardsIcon, *goldIcon;  
}

@property(nonatomic, retain) UILabel *turnNumberLabel, *pointsLabel, *cardsLabel, *goldLabel;
@property(nonatomic, retain) UIImageView *pointsIcon, *cardsIcon, *goldIcon;  

- (void) setForScoreDict:(NSDictionary*)scoreDict turnNumber:(int) turnNumber;


@end
