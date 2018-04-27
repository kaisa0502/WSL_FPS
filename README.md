
简书地址：[iOS 性能监测之FPS](https://www.jianshu.com/p/a3a4b060b9fd)

![FPS.gif](https://upload-images.jianshu.io/upload_images/1708447-aee78de2f47afe7d.gif?imageMogr2/auto-orient/strip)

>FPS ：Frames Per Second 的简称缩写，意思是每秒传输帧数，可以理解为我们常说的“刷新率”（单位为Hz）；FPS是测量用于保存、显示动态视频的信息数量。每秒钟帧数愈多，所显示的画面就会愈流畅，fps值越低就越卡顿，所以这个值在一定程度上可以衡量应用在图像绘制渲染处理时的性能。

> CADisplayLink 是一个用于显示的定时器，  它可以让用户程序的显示与屏幕的硬件刷新保持同步，iOS系统中正常的屏幕刷新率为60Hz（60次每秒）。 
CADisplayLink可以以屏幕刷新的频率调用指定selector，也就是说每次屏幕刷新的时候就调用selector，那么只要在selector方法里面统计每秒这个方法执行的次数，通过次数/时间就可以得出当前屏幕的刷新率了。
CADisplayLink 简介：https://www.jianshu.com/p/434ec6911148

初始化CADisplayLink，监测FPS值的代码如下：

 ```
 _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
        [_displayLink setPaused:YES];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

//这个方法的执行频率跟当前屏幕的刷新频率是一样的，屏幕每渲染刷新一次，就执行一次，那么1秒的时长执行刷新的次数就是当前的FPS值
- (void)displayLinkTick:(CADisplayLink *)link{
    
    //     duration 是只读的， 表示屏幕刷新的间隔 = 1/fps
    //     timestamp 是只读的， 表示上次屏幕渲染的时间点
    //    frameInterval 是表示定时器被触发的间隔， 默认值是1， 就是表示跟屏幕的刷新频率一致。
    //    NSLog(@"timestamp= %f  duration= %f frameInterval= %f",link.timestamp, link.duration, frameInterval);
    
    //初始化屏幕渲染的时间
    if (_beginTime == 0) {
        _beginTime = link.timestamp;
        return;
    }
    //刷新次数累加
    _count++;
    //刚刚屏幕渲染的时间与最开始幕渲染的时间差
    NSTimeInterval interval = link.timestamp - _beginTime;
    if (interval < 1) {
        //不足1秒，继续统计刷新次数
        return;
    }
    //刷新频率
    float fps = _count / interval;
    
    if (self.FPSBlock != nil) {
        self.FPSBlock(fps);
    }

    //1秒之后，初始化时间和次数，重新开始监测
    _beginTime = link.timestamp;
    _count = 0;
}
```

> FPS的值用悬浮视图来展示，方便实时查看。悬浮图的实现是利用了UIWindow的特性来实现的。
UIWindow简介： https://www.jianshu.com/p/cda083e44abd

```
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
```
