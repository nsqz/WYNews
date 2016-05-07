//
//  ShadeView.h
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShadeView : UIView

@property (nonatomic, assign)BOOL isOpen;
@property (nonatomic, strong)UIButton *openBtn;


// 点击按钮
@property (nonatomic, copy) void (^ShadeOpen)();
@property (nonatomic, copy)void (^ShadeStatre)();

@end
