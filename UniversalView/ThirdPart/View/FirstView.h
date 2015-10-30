//
//  FirstView.h
//  UniversalView
//
//  Created by wangxian on 15/10/30.
//  Copyright © 2015年 wangxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstView : UIView<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (nonatomic, strong) UIViewController *m_nav;
-(void)initView;
-(void)RefeshView;
@end
