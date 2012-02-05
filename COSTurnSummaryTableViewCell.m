//
//  COSTurnSummaryTableViewCell.m
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSTurnSummaryTableViewCell.h"
#import "COSConstants.h"

@implementation COSTurnSummaryTableViewCell
@synthesize turnNumberLabel, pointsLabel, cardsLabel, goldLabel;
@synthesize pointsIcon, cardsIcon, goldIcon;  


- (void) dealloc {
  [turnNumberLabel release];
  [pointsLabel release];
  [cardsLabel release];
  [goldLabel release];
  [pointsIcon release];
  [cardsIcon release];
  [goldIcon release];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      turnNumberLabel = [[UILabel alloc]init];
      turnNumberLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
      [self.contentView addSubview:turnNumberLabel];		

      pointsLabel = [[UILabel alloc]init];
      pointsLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
      [self.contentView addSubview:pointsLabel];		

      cardsLabel = [[UILabel alloc]init];
      cardsLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
      [self.contentView addSubview:cardsLabel];		

      goldLabel = [[UILabel alloc]init];
      goldLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
      [self.contentView addSubview:goldLabel];		
      
      pointsIcon = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star.png"]]autorelease];
      [self.contentView addSubview:pointsIcon];		

      goldIcon = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gold.png"]]autorelease];
      [self.contentView addSubview:goldIcon];		

      cardsIcon = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cards.png"]]autorelease];
      [self.contentView addSubview:cardsIcon];		

    }
    return self;
}


- (void) setForScoreDict:(NSDictionary*)scoreDict turnNumber:(int) turnNumber {
  turnNumberLabel.text = [NSString stringWithFormat:@"Turn %d:", turnNumber+1];
  pointsLabel.text = [NSString stringWithFormat:@"%d", [[[[scoreDict objectForKey:@"reward"]objectForKey:@"turns"]objectAtIndex:turnNumber]intValue]];
  cardsLabel.text = [NSString stringWithFormat:@"%d", [[[[scoreDict objectForKey:@"cards"]objectForKey:@"turns"]objectAtIndex:turnNumber]intValue]];
  goldLabel.text = [NSString stringWithFormat:@"%d", [[[[scoreDict objectForKey:@"gold"]objectForKey:@"turns"]objectAtIndex:turnNumber]intValue]];
}


- (void)layoutSubviews {
	[super layoutSubviews];
  
  int numLabelWidth = 20;
  int imageSize = 24;
  
  turnNumberLabel.frame = CGRectMake(PADDING, 0, 85, self.contentView.frame.size.height);
  
  pointsLabel.frame = CGRectMake(turnNumberLabel.frame.size.width+PADDING*3, 
                                 0, 
                                 numLabelWidth, 
                                 self.contentView.frame.size.height);
  pointsIcon.frame = CGRectMake(pointsLabel.frame.origin.x + pointsLabel.frame.size.width, 
                                self.contentView.frame.size.height/2-imageSize/2, 
                                imageSize, 
                                imageSize); 
  
  goldLabel.frame = CGRectMake(pointsIcon.frame.origin.x+pointsIcon.frame.size.width+PADDING*2, 
                                0, 
                                numLabelWidth, 
                                self.contentView.frame.size.height); 
  goldIcon.frame = CGRectMake(goldLabel.frame.size.width+goldLabel.frame.origin.x, 
                               self.contentView.frame.size.height/2-imageSize/2, 
                               imageSize, 
                               imageSize); 
  cardsLabel.frame = CGRectMake(goldIcon.frame.origin.x+goldIcon.frame.size.width+PADDING*2, 
                                0, 
                                numLabelWidth, 
                                self.contentView.frame.size.height); 
  cardsIcon.frame = CGRectMake(cardsLabel.frame.size.width+cardsLabel.frame.origin.x, 
                               self.contentView.frame.size.height/2-imageSize/2, 
                               imageSize, 
                               imageSize); 
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
