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
#import "FirstView.h"


@interface MainController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *m_view;
@property (nonatomic, strong) SecondViewController *m_second;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnPage1;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnPage2;
@property (weak, nonatomic) IBOutlet UIButton *m_btnPage3;
@property (weak, nonatomic) IBOutlet UIButton *m_btnPage4;
@property (weak, nonatomic) IBOutlet UIScrollView *m_ScrollView;

@end

@implementation MainController
@synthesize m_view = m_view;
@synthesize m_second = m_second;
@synthesize m_ScrollView = m_ScrollView;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主界面";
    [self.navigationItem setHidesBackButton:YES];
    [self InitScrollView];

    self.m_BtnPage1.tag = 0;
    self.m_BtnPage2.tag = 1;
    self.m_btnPage3.tag = 2;
    self.m_btnPage4.tag = 3;
    
    [self.m_BtnPage1 addTarget:self action:@selector(onClickPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_BtnPage2 addTarget:self action:@selector(onClickPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_btnPage3 addTarget:self action:@selector(onClickPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_btnPage4 addTarget:self action:@selector(onClickPage:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)onClickPage:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger x = btn.tag * SCREEN_WIDTH;
    [m_ScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    [self WhichPageShow:btn.tag];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

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


-(void)InitScrollView{
    [m_ScrollView setContentSize:CGSizeMake(SCREEN_WIDTH * 4, 0)];
    m_ScrollView.showsHorizontalScrollIndicator = NO;
    m_ScrollView.showsVerticalScrollIndicator = NO;
    m_ScrollView.pagingEnabled = YES;
    m_ScrollView.delegate = self;
    
    /////第一个界面
    FirstView *view_1 = [[[NSBundle mainBundle] loadNibNamed:@"FirstView" owner:nil options:nil] lastObject];
    [view_1 setFrame:CGRectMake(0, 0, SCREEN_WIDTH, m_ScrollView.frame.size.height)];
    [m_ScrollView addSubview:view_1];
    [view_1 setBackgroundColor:[UIColor redColor]];
    [view_1 initView];
    [view_1 RefeshView];
 
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.m_selectedPage = scrollView.contentOffset.x/SCREEN_WIDTH;
    [self WhichPageShow:self.m_selectedPage];
    
}


-(void)WhichPageShow:(PageSelected)whichpage{
    [self ClearButton];
    switch (whichpage) {
        case Page_One:
        {
            [self.m_BtnPage1 setBackgroundColor:[UIColor redColor]];
        }
            break;
        case Page_Two:{
            [self.m_BtnPage2 setBackgroundColor:[UIColor redColor]];
        }
            break;
        case Page_Three:{
            [self.m_btnPage3 setBackgroundColor:[UIColor redColor]];
        }
            break;
        case Page_Four:{
            [self.m_btnPage4 setBackgroundColor:[UIColor redColor]];
        }
            break;
        default:
            break;
    }
}

-(void)ClearButton{
    [self.m_BtnPage1 setBackgroundColor:[UIColor clearColor]];
    [self.m_BtnPage2 setBackgroundColor:[UIColor clearColor]];
    [self.m_btnPage3 setBackgroundColor:[UIColor clearColor]];
    [self.m_btnPage4 setBackgroundColor:[UIColor clearColor]];
}

@end
