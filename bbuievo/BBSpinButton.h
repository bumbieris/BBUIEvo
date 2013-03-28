//
//  BBSpinButton.h
//  bbuievo
//
//  Created by bumbieris on 28/03/2013.
//  Copyright (c) 2013 bumbieris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSpinButton : UIControl
@property (readonly, nonatomic) UILabel* label;
@property (readonly, nonatomic) UIActivityIndicatorView* spinner;
@property (assign, nonatomic) CGFloat spinnerXSpacing;
@property (assign, nonatomic) BOOL active;
@property (assign, nonatomic) NSString* text;
@property (assign, nonatomic) UIFont* font;
@property (strong, nonatomic) UIColor* textColor;
@property (strong, nonatomic) UIColor* highlightColor;

- (void) showSpinner;
- (void) hideSpinner;

@end
