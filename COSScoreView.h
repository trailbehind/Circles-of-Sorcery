//
//  COSScoreView.h
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class COSScoreKeeper, ScoreTable;

@interface COSScoreView : UIViewController <UITextFieldDelegate> {
  COSScoreKeeper *scoreKeeper;
  ScoreTable *scoreTable;
  UITextField *highScoreNameField;
}

- (id) initWithScoreKeeper:(COSScoreKeeper*)keeper;
- (UILabel*) labelWithFrame:(CGRect)frame text:(NSString*)text font:(UIFont*)font;


@end
