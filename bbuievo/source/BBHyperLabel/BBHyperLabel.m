//
//  BBHyperLabel.m
//  iBang
//
//  Created by bumbieris on 22/03/2013.
//  Copyright (c) 2013 bumbieris. All rights reserved.
//

#import "BBHyperLabel.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface BBHyperLabel()
- (void) initDefaults;
- (void) transitionSelected: (BOOL) tf;
@property (nonatomic, assign) BOOL down;
@end

@implementation BBHyperLabel

- (void) deselect
{
    [self transitionSelected:FALSE];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaults];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initDefaults];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.down = YES;
    [self transitionSelected: YES];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.down = NO;
    if (_action)
        SuppressPerformSelectorLeakWarning([self.target performSelector:self.action withObject:self]);
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.down = NO;
}

#pragma mark - drawing

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.underline){
        
        CGSize sz = [self.text sizeWithFont:self.font];
        CGFloat y = floorf((self.bounds.size.height - sz.height) / 2);
        
        // only draw if y > 0 (e.g. line beneath text - not strikethrough)
        // increase size of label bounds in IB if not
        if (y >= 0){
            y += sz.height;
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetStrokeColorWithColor(context, self.textColor.CGColor);
            CGContextSetLineWidth(context, 1.0f);
            CGContextMoveToPoint(context, self.bounds.origin.x, y);
            CGContextAddLineToPoint(context, self.bounds.origin.x +sz.width, y);
            CGContextStrokePath(context);
        }
    }
}

#pragma mark - private

- (void) initDefaults
{
    //some defaults
    self.normalColor = [UIColor blueColor];
    self.downColor = [UIColor cyanColor];
    self.textColor = self.normalColor;
    self.underline = TRUE;
}

- (void) transitionSelected: (BOOL) tf
{
    UIColor* transition;
    if (tf)
        transition = self.downColor;
    else
        transition = self.normalColor;
    
    [UIView transitionWithView:self duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.textColor = transition;
    } completion:nil];
}

@end
