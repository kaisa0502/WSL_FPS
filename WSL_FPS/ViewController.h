//
//  ViewController.h
//  WSL_FPS
//
//  Created by 王双龙 on 2018/4/24.
//  Copyright © 2018年 王双龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    listStyle1 = 0,
    listStyle2,
    listStyle3
} ListStyle;

@interface ViewController : UIViewController

/**
 不同的列表显示样式，不同的FPS值
 */
@property (nonatomic, assign) ListStyle listStyle;

@end

