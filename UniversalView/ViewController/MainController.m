//
//  MainController.m
//  UniversalView
//
//  Created by wangxian on 15/10/29.
//  Copyright © 2015年 wangxian. All rights reserved.
//

#import "MainController.h"
#import "UIViewController+HUD.h"
#import "SecondViewController.h"
#import "UIView+Additions.h"

@interface MainController ()
@property (nonatomic, strong) UIView *m_view;
@property (nonatomic, strong) SecondViewController *m_second;

@end

@implementation MainController
@synthesize m_view = m_view;
@synthesize m_second = m_second;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主界面";
    
    ////////////////////////////////////////////////////////////
    //设置navigationbar颜色
    [self setNavigationBarStyle];
    //title颜色
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    ///self.navigationController.navigationBarHidden = NO;
    //bar字体颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    ///////////////////////////////////////////////////////////
    
    m_view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 30, SCREEN_HEIGHT/2 - 30, 60, 60)];
    [m_view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:m_view];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.secondViewController.view.left = 92;
    } completion:^(BOOL finished) {
      
    }];

    ;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(SecondViewController *)secondViewController{
    if(!m_second){
        m_second = [[SecondViewController alloc] init];
        m_second.view.frame = [[UIScreen mainScreen] bounds];;
        m_second.navigationController.navigationBarHidden = YES;
        [self.view addSubview:m_second.view];
    }
    return m_second;
}

@end
