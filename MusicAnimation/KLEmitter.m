//
//  KLEmitter.h
//  TheEngineSample
//
//  Created by Kevin_London on 14-9-4.
//  Copyright (c) 2014年 A Tasty Pixel. All rights reserved.
//

#import "KLEmitter.h"
#import <QuartzCore/CoreAnimation.h>
//#import "UIColor-Expanded.h"

@interface KLEmitter()

@property (nonatomic,strong) CAEmitterLayer *ringEmitter;


@end

@implementation KLEmitter



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        [self makeEmitter];
    }
    return self;
}

- (void)makeEmitter{
    CGRect viewBounds = self.layer.bounds;
	

	self.ringEmitter = [CAEmitterLayer layer];
	
	self.ringEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0f, viewBounds.size.height/2.0f);
	self.ringEmitter.emitterSize	= CGSizeMake(50, 0);
	self.ringEmitter.emitterMode	= kCAEmitterLayerOutline;
	self.ringEmitter.emitterShape	= kCAEmitterLayerCircle;
	self.ringEmitter.renderMode		= kCAEmitterLayerBackToFront;
    
	CAEmitterCell* Emitter1 = [CAEmitterCell emitterCell];
	[Emitter1 setName:@"Emitter1"];
	Emitter1.birthRate			= 0;
	Emitter1.velocity			= 40;
	Emitter1.scale				= 0.5;
	Emitter1.scaleSpeed			=-0.2;
	Emitter1.greenSpeed			=-0.2;
	Emitter1.redSpeed			=-0.5;
	Emitter1.blueSpeed			=-0.5;
	Emitter1.lifetime			= 2;
	Emitter1.color = [self.showColor CGColor];

	

	CAEmitterCell* circle = [CAEmitterCell emitterCell];
	[circle setName:@"circle"];
	circle.birthRate		= 10;
	circle.emissionLongitude = M_PI * 0.5 +1;	// 方向
    circle.zAcceleration  = -1;
	circle.velocity			= 50;
	circle.scale			= 0.5;
	circle.scaleSpeed		= -0.2;
	circle.greenSpeed		=-0.1;
	circle.redSpeed			= -0.2;
	circle.blueSpeed		= 0.1;
	circle.alphaSpeed		=-0.42;
	circle.lifetime			= 1;
	circle.color = [[UIColor whiteColor] CGColor];
	circle.contents = (id) [[UIImage imageNamed:@"DazRing"] CGImage];
    
    
	CAEmitterCell* ball = [CAEmitterCell emitterCell];
	[ball setName:@"ball"];
	ball.birthRate		= 2;
	ball.velocity		= 140;
	ball.zAcceleration  = -1;
	ball.emissionLongitude = -M_PI ;
	ball.scale			= 1.5;
	ball.scaleSpeed		=-0.2;
	ball.greenSpeed		=-0.1;
	ball.redSpeed		= 0.4;
	ball.blueSpeed		=-0.1;
	ball.alphaSpeed		=-0.2;
	ball.lifetime		= 2.0;
	ball.color = [[UIColor blueColor] CGColor];

	self.ringEmitter.emitterCells = [NSArray arrayWithObject:Emitter1];
	Emitter1.emitterCells = [NSArray arrayWithObjects:circle, ball, nil];

	[self.layer addSublayer:self.ringEmitter];
}

- (void)animationWith:(CGFloat)value{
    
    
    // 爆炸动画..
	CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.Emitter1.birthRate"];
	burst.fromValue			= [NSNumber numberWithFloat: (value-10)*3];
	burst.toValue			= [NSNumber numberWithFloat: 0.0];
	burst.duration			= 0.5;
	burst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.ringEmitter setValue:@(value) forKeyPath:@"emitterCells.Emitter1.velocity"];
    [self.ringEmitter setValue:@(value) forKeyPath:@"emitterCells.Emitter1.emitterCells.circle.velocity"];
//    [self.ringEmitter setValue:@(value/500) forKeyPath:@"emitterCells.Emitter1.emitterCells.circle.greenSpeed"];//
    [self.ringEmitter setValue:@(value/5) forKeyPath:@"emitterCells.Emitter1.emitterCells.circle.birthRate"];
	[self.ringEmitter addAnimation:burst forKey:@"burst"];
    
    //动画中心位置
    CGPoint position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);

	[CATransaction begin];
	[CATransaction setDisableActions: YES];
	self.ringEmitter.emitterPosition	= position;
	[CATransaction commit];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
