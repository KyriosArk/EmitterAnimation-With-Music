//
//  KLEmitter.h
//  TheEngineSample
//
//  Created by Kevin_London on 14-9-4.
//  Copyright (c) 2014年 A Tasty Pixel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLEmitter : UIView

@property (nonatomic,strong) UIColor * showColor;

- (void)makeEmitter;

- (void)animationWith:(CGFloat)value;

@end
