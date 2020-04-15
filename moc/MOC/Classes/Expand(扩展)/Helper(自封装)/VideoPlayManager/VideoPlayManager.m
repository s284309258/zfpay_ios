//
//  VideoPlayManager.m
//  BOB
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import "VideoPlayManager.h"
#import "SJVideoPlayer.h"
#import "SJBaseVideoPlayer.h"

@interface VideoPlayManager()
@property (nonatomic, strong) SJVideoPlayer *player;
@end

@implementation VideoPlayManager
+ (instancetype)share {
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:shared selector:@selector(videoTap) name:@"VideoTapAction" object:nil];
    });
    return shared;
}

- (void)play:(NSString *)url superView:(UIView *)superView {
    if([NSURL URLWithString:url] == nil) {
        return;
    }
    
    self.player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:url]];
    self.player.view.frame = superView.bounds;
    [superView addSubview:self.player.view];
    [self performSelector:@selector(fullPlay) withObject:nil afterDelay:0.25];
}

- (void)fullPlay {
    self.player.fitOnScreen = YES;
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 200)];
//    v.backgroundColor = [UIColor greenColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //self.currentPlayView.backgroundColor = [UIColor redColor];
        UIView *view = [UIView new];
        view.frame = [[UIScreen mainScreen] bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoTap)];
        [view addGestureRecognizer:tap];
        
        SJEdgeControlButtonItem *item = [SJEdgeControlButtonItem frameLayoutWithCustomView:view tag:1];
        //item.delegate = self;
        [self.player.defaultEdgeControlLayer.centerAdapter addItem:item];
        [self.player.defaultEdgeControlLayer.centerAdapter reload];
    });
}

- (void)videoTap {
    self.player.fitOnScreen = NO;
    [self.player stopAndFadeOut];
}

- (SJVideoPlayer *)player {
    if (!_player) {
        _player = [[SJVideoPlayer alloc] init];
        _player.URLAsset.alwaysShowTitle = YES;
        SJVideoPlayerSettings.commonSettings.progress_traceColor = [UIColor moBlue];
    }
    return _player;
}
@end
