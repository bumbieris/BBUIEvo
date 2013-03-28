//
//  BBSpinButton.m
//  bbuievo
//
//  Created by bumbieris on 28/03/2013.
//  Copyright (c) 2013 bumbieris. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "BBSpinButton.h"

@interface BBSpinButton()

@property (assign) BOOL touchUp;
@property (weak, nonatomic) IBOutlet UILabel* impLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* impSpinner;
@property (nonatomic, assign) CGFloat spinnerLabelWidth;
@property (nonatomic, assign) CGFloat labelWidth;

- (void) setup;
- (void) centreLabelWidth: (CGFloat) width;
- (void) positionControls;

@end

@implementation BBSpinButton

- (void) setText:(NSString *)text
{
    self.impLabel.text = text;
    [self positionControls];
}

- (void) setFont:(UIFont *)font
{
    self.impLabel.font = font;
    [self positionControls];
}

- (UIFont*) font
{
    return self.impLabel.font;
}

- (NSString*) text
{
    return self.impLabel.text;
}

- (void) setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    if (_touchUp) self.impLabel.textColor = textColor;
}

- (void) setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;
    if (!_touchUp) self.impLabel.textColor = highlightColor;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchUp = NO;
    self.impLabel.textColor = _highlightColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_touchUp)
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    _touchUp = YES;
    self.impLabel.textColor = _textColor;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.bounds, p)){
        self.impLabel.textColor = _textColor;
        _touchUp = YES;
    }
    
}

- (void) showSpinner
{
    _active = TRUE;
    [UIView animateWithDuration:0.3 animations:^{
        [_impSpinner startAnimating];
        [self centreLabelWidth:_spinnerLabelWidth];
        _impSpinner.alpha = 1.f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void) hideSpinner
{
    _active = FALSE;
    [UIView animateWithDuration:0.3 animations:^{
        [self centreLabelWidth:_labelWidth];
        _impSpinner.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_impSpinner stopAnimating];
    }];
}

#pragma mark - private

- (void) setup
{
    _touchUp = YES;
    _highlightColor = [UIColor blueColor];
    _textColor = [UIColor blackColor];
    
    self.userInteractionEnabled = YES;
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    self.layer.borderWidth = 1.f;
    self.layer.cornerRadius = 5.f;
    
    _spinnerLabelWidth = 10.f;
    
    UINib* nib = [UINib nibWithNibName:@"BBSpinButton" bundle:[NSBundle mainBundle]];
    NSArray* items = [nib instantiateWithOwner:self options:nil];
    UIView* view = [items objectAtIndex:0];
    view.frame = self.bounds;
    [self addSubview:view];
    self.impSpinner.alpha = 0.f;

    [self positionControls];
    
}

- (void) positionControls
{
    CGSize sz = [self.impLabel.text sizeWithFont:self.impLabel.font
                                        forWidth:self.bounds.size.width lineBreakMode:self.impLabel.lineBreakMode];
    _labelWidth = sz.width;
    _spinnerLabelWidth = sz.width + _spinnerXSpacing + self.impSpinner.frame.size.width;
    
    if (_active)
        [self centreLabelWidth:_spinnerLabelWidth];
    else
        [self centreLabelWidth:sz.width];
    
    CGRect f = self.impSpinner.frame;
    f.origin.x = (self.bounds.size.width - sz.width)/2 + sz.width;
    self.impSpinner.frame = f;

}

- (void) centreLabelWidth: (CGFloat) width
{
    CGFloat xMid = (int)(self.bounds.size.width - width)/2;
    CGRect f = self.impLabel.frame;
    f.origin.x= xMid;
    self.impLabel.frame = f;
}

@end
