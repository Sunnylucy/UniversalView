//
//  LoginViewController.m
//  UniversalView
//
//  Created by wangxian on 15/10/29.
//  Copyright © 2015年 wangxian. All rights reserved.
//

#import "LoginViewController.h"
#import "EAIntroViewWelcome.h"
#import "MainController.h"
#import "WZFlashButton.h"
#import "JTBorderDotAnimation.h"
@interface LoginViewController ()

//背景图
@property (nonatomic, strong) UIWebView *m_web;
@property (nonatomic, strong) WZFlashButton *m_btnLogin;
@property (nonatomic, strong) UIButton *m_btnRegister;
@property (nonatomic, strong) UIView *m_blackView;
@property (nonatomic, strong) JTBorderDotAnimation *dotAnimation2;
@end

@implementation LoginViewController
@synthesize m_web = m_web;
@synthesize m_btnLogin = m_btnLogin;
@synthesize m_btnRegister = m_btnRegister;
@synthesize m_blackView = m_blackView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_web = [[UIWebView alloc] init];
    m_blackView = [[UIView alloc] init];
    m_btnLogin = [[WZFlashButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, UI_HEIGHT)];
    m_btnRegister = [[UIButton alloc] init];
    
    
    [self.view addSubview:m_web];
    [self.view addSubview:m_blackView];
    [self.view addSubview:m_btnLogin];
    [self.view addSubview:m_btnRegister];
    
  
    [m_blackView setBackgroundColor:[UIColor blackColor]];
    m_blackView.alpha = 0.15;
    
    m_btnLogin.backgroundColor = [UIColor colorWithRed:153.0f/255.0f green:204.0f/255.0f blue:0 alpha:1.0f];
    m_btnLogin.flashColor = [UIColor yellowColor];
    [m_btnLogin setText:@"登录" withTextColor:[UIColor whiteColor]];
    WS(ws);
    m_btnLogin.clickBlock = ^(void) {
        [ws Login];
    };
    
    [m_btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [m_btnLogin setTintColor:[UIColor whiteColor]];
    m_btnLogin.layer.borderWidth = 1.0f;
    m_btnLogin.layer.borderColor = [UIColor whiteColor].CGColor;
    [m_btnRegister setTintColor:[UIColor whiteColor]];
    m_btnRegister.layer.borderColor = [UIColor whiteColor].CGColor;
    m_btnRegister.layer.borderWidth = 1.0f;
    [m_btnRegister setBackgroundColor:[UIColor clearColor]];
    [m_btnLogin setBackgroundColor:[UIColor clearColor]];
    
    //[m_btnLogin addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    [m_btnRegister addTarget:self action:@selector(AccountRegister) forControlEvents:UIControlEventTouchUpInside];

    
    //添加第一次登录引导页
    if ([Common isFirstLogin]) {
        EAIntroViewWelcome *welcome = [[EAIntroViewWelcome alloc] init];
        [welcome show:(id)self type:WelcomeStyle_CrossDissolve];
    }
    [self InitWeb];
    
    
    
    self.dotAnimation2 = [JTBorderDotAnimation new];
    self.dotAnimation2.animatedView = m_btnLogin;
    self.dotAnimation2.numberPoints = 5.;
    self.dotAnimation2.pointColor = [UIColor orangeColor];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    WS(ws);
    [m_web mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 40));
    }];
    
    [m_blackView mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
    
    [m_btnLogin mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(ws.view.mas_centerX);
        make.centerY.equalTo(ws.view.mas_centerY).offset(100);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, UI_HEIGHT));
    }];
    
    [m_btnRegister mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(ws.view.mas_centerX);
        make.top.equalTo(ws.m_btnLogin.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, UI_HEIGHT));
    }];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [Common ViewOffset:m_btnRegister];
    //[Common ViewOffset:m_web];
    [Common ViewOffset:m_btnLogin];
    [self.dotAnimation2 start];
}




-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

-(void)InitWeb{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Login" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    [m_web loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    m_web.userInteractionEnabled = NO;
    [NSThread sleepForTimeInterval:1.0f];
   
}



-(void)Login{
    NSLog(@"登录");
    MainController *fv = [[MainController alloc] init];
    [self.navigationController pushViewController:fv animated:YES];
}

-(void)AccountRegister{
    NSLog(@"注册");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -----NetWork ----------
-(void)RequestLogin{
    AFHTTPRequestOperationManager * manger = [[AFHTTPRequestOperationManager alloc]init];
    [manger customRequestHeader];
    NSDictionary * tempDic = @{@"userId":[[Common singleton] ReturnUserId], @"type":@"3", @"key":@"", @"pageIndex":@"1", @"pageSize":@"100"};
//    [manger GET:API_BUSINESS_GET_USERLIST parameters:tempDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSDictionary * responseDic = responseObject;
//        self.m_blackListData = [responseDic objectForKey:@"account"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
 
}




@end
