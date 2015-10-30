//
//  BaseViewController.m
//  UniversalView
//
//  Created by wangxian on 15/10/28.
//  Copyright © 2015年 wangxian. All rights reserved.
//

#import "BaseViewController.h"
#import "Reachability.h" //用来检测是否有网络连接
#import "Common.h"

@interface BaseViewController ()



-(void)reachabilityChanged:(NSNotification*)note;




@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**    以下代码用来判断是否有网络连接     begin   **/
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            //[Common showMessage:@"有网络！！！"];
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [Common showMessage:@"无网络！！！"];
        });
    };
    [reach startNotifier];
    /**  end   **/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        //[Common showMessage:@"有网络！！！"];
    }
    else
    {
        [Common showMessage:@"无网络！！！"];
    }
}

@end
