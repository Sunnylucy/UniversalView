//
//  EAIntroViewWelcome.h
//  UniversalView
//
//  Created by wangxian on 15/10/29.
//  Copyright © 2015年 wangxian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EAIntroView.h"
enum{
    WelcomeStyle_CrossDissolve = 0,        //渐隐
    WelcomeStyle_Basic,
    WelcomeStyle_WithFixedTitle,
    WelcomeStyle_CustomIntro,
    WelcomeStyle_WithCustomView,
    WelcomeStyle_SeparatePages,
};
@interface EAIntroViewWelcome : NSObject
-(void)show:(id)parent type:(int)type;
@end
