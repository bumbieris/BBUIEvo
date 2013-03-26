//
//  BBHyperLabel.h
//  iBang
//
//  Created by bumbieris on 22/03/2013.
//  Copyright (c) 2013 bumbieris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBHyperLabel : UILabel

@property (weak,nonatomic) id target;
@property (nonatomic) SEL action;

@property (strong, nonatomic) UIColor* normalColor;
@property (strong, nonatomic) UIColor* downColor;
@property (assign, nonatomic) BOOL underline;

- (void) deselect;

@end

