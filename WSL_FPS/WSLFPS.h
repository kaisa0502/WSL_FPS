//
//  WSLFPS.h
//  WSL_FPS
//
//  Created by 王双龙 on 2018/4/25.
//  Copyright © 2018年 https://www.jianshu.com/p/a3a4b060b9fd All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^WSLFPSBlock)(float fps);

@interface WSLFPS : NSObject

/**
 监测过程中输出FPS的回调
 */
@property (nonatomic, copy) WSLFPSBlock FPSBlock;

/**
 单例对象
 */
+ (WSLFPS *)sharedFPSIndicator;

/**
 开始监测
 */
- (void)startMonitoring;

/**
 暂停监测
 */
- (void)pauseMonitoring;

/**
 移除监测
 */
- (void)removeMonitoring;

@end
