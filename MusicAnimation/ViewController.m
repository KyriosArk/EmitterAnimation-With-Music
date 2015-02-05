//
//  ViewController.m
//  MusicAnimation
//
//  Created by mymac on 15/1/23.
//  Copyright (c) 2015年 ZC. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "KLEmitter.h"
@interface ViewController (){
    NSTimer * timer;
    AVAudioPlayer * player;
    KLEmitter * emitterAnimation;
    KLEmitter * emitterAnimation2;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //加载粒子动画View
    emitterAnimation2 = [[KLEmitter alloc] initWithFrame:self.view.bounds];
    emitterAnimation2.showColor = [UIColor blackColor];
    [emitterAnimation2 makeEmitter];
    [self.view addSubview:emitterAnimation2];
    
    emitterAnimation = [[KLEmitter alloc] initWithFrame:self.view.bounds];
    emitterAnimation.showColor = [UIColor whiteColor];
    [emitterAnimation makeEmitter];
//    emitterAnimation.backgroundColor = [UIColor blackColor];
    [self.view addSubview:emitterAnimation];
    

    
    //音乐文件路径
    NSString * path = [[NSBundle mainBundle] pathForResource:@"爱情三十六计" ofType:@"mp3"];
    NSURL * url = [NSURL fileURLWithPath:path];
    
    //实例化播放器
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    player.meteringEnabled = YES;
    [player play];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(readMusicPeak) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *    读取音乐数据
 */
-(void)readMusicPeak{
    [player updateMeters];
    float avg0 = [player averagePowerForChannel:0];
    float peak0 = [player peakPowerForChannel:0];
    
    [emitterAnimation animationWith:(peak0+10.f)*10];
//    [emitterAnimation2 animationWith:(avg0+15.f)*10];
    
}

@end
