//
//  MainController.h
//  UniversalView
//
//  Created by wangxian on 15/10/29.
//  Copyright © 2015年 wangxian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


typedef enum{
    Page_One = 0,
    Page_Two,
    Page_Three,
    Page_Four,
    
    
}PageSelected;

@interface MainController : BaseViewController
@property (nonatomic, assign) PageSelected m_selectedPage;
@end
