//
//  TAAnimatedDotView.m
//  TAPageControl
//
//  Created by Tanguy Aladenise on 2015-01-22.
//  Copyright (c) 2015 Tanguy Aladenise. All rights reserved.
//

#import "TAAnimatedDotView.h"

static CGFloat const kAnimateDuration = 1;

@implementation TAAnimatedDotView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    
    return self;
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    self.layer.borderColor  = [UIColor clearColor].CGColor;//dotColor.CGColor;
}

-(void)setDotCenterIfEmpty:(BOOL)dotCenterIfEmpty{
    
    _dotCenterIfEmpty = dotCenterIfEmpty;
    if (dotCenterIfEmpty) {
        self.backgroundColor    = [UIColor clearColor];
        self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
        if (_dotColor) {
            self.layer.borderColor  = _dotColor.CGColor;
        }else{
            self.layer.borderColor  = [UIColor whiteColor].CGColor;
        }
        self.layer.borderWidth  = 2;
    }else{
        if (_dotColor) {
            self.backgroundColor    = self.dotColor;
        }else{
            self.backgroundColor    = [UIColor clearColor];
        }
        
        self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
        if (_dotColor) {
            self.layer.borderColor  = [UIColor clearColor].CGColor;//self.dotColor.CGColor;
        }else{
            self.layer.borderColor  = [UIColor whiteColor].CGColor;
        }
        
        self.layer.borderWidth  = 2;
    }
}

- (void)initialization
{
    _dotColor = [UIColor whiteColor];
    _dotCenterIfEmpty = YES;
    self.backgroundColor    = [UIColor clearColor];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    self.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.layer.borderWidth  = 2;
}


- (void)changeActivityState:(BOOL)active
{
    if (active) {
        [self animateToActiveState];
    } else {
        [self animateToDeactiveState];
    }
}


- (void)animateToActiveState
{
    CGFloat R, G, B;
    UIColor *uiColor = _dotColor;
    CGColorRef cgColor = [uiColor CGColor];
    NSInteger numComponents = CGColorGetNumberOfComponents(cgColor);
    if (numComponents == 4){
        {
            const CGFloat *components = CGColorGetComponents(cgColor);
            R = components[0];
            G = components[1];
            B = components[2];
        }
    }
    
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:-20 options:UIViewAnimationOptionCurveLinear animations:^{
        if (self.dotCenterIfEmpty) {
            self.backgroundColor = [UIColor clearColor];
            
        }else{
            //设置dot选中状态下的颜色
            self.backgroundColor = [UIColor colorWithRed:R green:G blue:B alpha:1.0];
            //也可以设置位默认的颜色，不需要修改透明度
            //self.backgroundColor = _dotColor;
        }
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } completion:nil];
}

- (void)animateToDeactiveState
{
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if (self.dotCenterIfEmpty) {
            self.backgroundColor = [UIColor clearColor];
        }else{
            self.backgroundColor = _dotColor;
        }
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
