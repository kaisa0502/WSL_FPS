//
//  WSLSuspendingView.h
//  WSL_FPS
//
//  Created by 王双龙 on 2018/4/26.
//  Copyright © 2018年 https://www.jianshu.com/p/a3a4b060b9fd All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//悬浮窗口
@interface WSLSuspendingView : NSObject

/**
 展示FPS的视图
 */
@property (nonatomic, strong) UILabel * fpsLabel;

/**
 单例
 */
+ (WSLSuspendingView *)sharedSuspendingView;

/**
 关闭悬浮窗视图
 */
- (void)closeSuspendingView;

@end
