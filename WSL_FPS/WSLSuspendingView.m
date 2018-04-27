//
//  WSLSuspendingView.m
//  WSL_FPS
//
//  Created by 王双龙 on 2018/4/26.
//  Copyright © 2018年 https://www.jianshu.com/p/a3a4b060b9fd All rights reserved.
//

#import "WSLSuspendingView.h"

@interface WSLSuspendingView ()

//悬浮球视图
@property (nonatomic, strong) UIWindow * window;

@end

@implementation WSLSuspendingView

+ (WSLSuspendingView *)sharedSuspendingView{
    static dispatch_once_t onceToken;
    static WSLSuspendingView *suspendingView;
    dispatch_once(&onceToken, ^{
        suspendingView = [[WSLSuspendingView alloc] init];
    });
    return suspendingView;
}

- (instancetype)init{
    
    if (self == [super init]) {
        
        _fpsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        _fpsLabel.textAlignment = NSTextAlignmentCenter;
        _fpsLabel.backgroundColor = [UIColor orangeColor];
        _fpsLabel.font = [UIFont systemFontOfSize:15];
        _fpsLabel.alpha = 0.7;
        
        UIViewController * viewc = [[UIViewController alloc] init];
        _window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        _window.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, 64);
        _window.windowLevel = UIWindowLevelAlert + 1;
        _window.layer.cornerRadius = 10;
        _window.clipsToBounds = YES;
        _window.rootViewController = viewc;
        [_window addSubview:_fpsLabel];
        [_window makeKeyAndVisible];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        _window.userInteractionEnabled = YES;
        [_window addGestureRecognizer:pan];
    }
    return self;
}

- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    
    CGPoint  translation = [panGesture translationInView:_window];
    CGFloat percentComplete = 0.0;
    
    _window.center = CGPointMake(_window.center.x + translation.x,
                                        _window.center.y + translation.y);
    [panGesture setTranslation:CGPointZero inView:_window];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateEnded:
            break;
        default:
            break;
    }
    
}

- (void)closeSuspendingView{
    [_window resignKeyWindow];
    _window = nil;
}


@end
