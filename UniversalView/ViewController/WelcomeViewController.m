//
//  WelcomeViewController.m
//  UniversalView
//
//  Created by wangxian on 15/10/28.
//  Copyright © 2015年 wangxian. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *m_scrollview; //背景滑动
@property (nonatomic, strong) UIView *m_bottomView; // 底部按钮
@property (nonatomic, strong) UIPageControl *m_pageControl; //滑动控件
@end

@implementation WelcomeViewController
@synthesize m_scrollview = m_scrollview;
@synthesize m_bottomView = m_bottomView;
@synthesize m_pageControl = m_pageControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    m_scrollview = [[UIScrollView alloc] initWithFrame:self.view.frame];
    m_bottomView = [[UIView alloc] init];
    m_pageControl = [[UIPageControl alloc] init];
    
    //添加
    [self.view addSubview:m_scrollview];
    [self.view addSubview:m_pageControl];
    [self.view addSubview:m_bottomView];
    //设置
    m_scrollview.pagingEnabled = YES;
    m_scrollview.delegate = self;
    m_scrollview.scrollEnabled = YES;
    m_scrollview.showsHorizontalScrollIndicator = NO;
    m_scrollview.showsVerticalScrollIndicator = NO;
    
    
    [m_bottomView setBackgroundColor:[UIColor blackColor]];
    [m_bottomView setAlpha:0.05];
    
    
    [m_scrollview setBackgroundColor:[UIColor redColor]];
    [m_pageControl setBackgroundColor:[UIColor yellowColor]];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    WS(ws);
    [m_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,  SCREEN_HEIGHT));
    }];
    
    [m_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX .equalTo(ws.view.mas_centerX);
         make.centerY.equalTo(ws.view.mas_centerY).offset(50);
         make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    
    [m_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX .equalTo(ws.view.mas_centerX);
        make.top.equalTo(ws.m_pageControl.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];

    [self InitImage];
}


-(void)InitImage{
    NSLog(@"初始化界面");
    NSMutableArray *ImageArray = [[NSMutableArray alloc] init]; //初始化
    
    UIImage *imag1 = [UIImage imageNamed:@"Guide_one"];
    [ImageArray addObject:imag1];
    
    UIImage *imag2 = [UIImage imageNamed:@"Guide_two"];
    [ImageArray addObject:imag2];
    
    
    UIImage *imag3 = [UIImage imageNamed:@"Guide_Three"];
    [ImageArray addObject:imag3];
    
    
    [self InitScrollPage:ImageArray];
}


-(void)InitScrollPage:(NSMutableArray *)ImageArray{
    if (!ImageArray) {
        return;
    }
    NSUInteger pageCount = ImageArray.count;
    m_pageControl.numberOfPages = pageCount;
    m_pageControl.currentPage = 0;
    [m_scrollview setContentSize:CGSizeMake(SCREEN_WIDTH * pageCount, 0)];
    for (int i = 0; i < ImageArray.count; i++) {
        UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [ImgView setImage:[ImageArray objectAtIndex:i]];
        [m_scrollview addSubview:ImgView];
    }
}


#pragma mark ---UIScrollView -----
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger iCurrentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
    m_pageControl.currentPage = iCurrentPage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
