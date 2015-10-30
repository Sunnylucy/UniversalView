//
//  ViewController.m
//  UniversalView
//
//  Created by wangxian on 15/10/28.
//  Copyright © 2015年 wangxian. All rights reserved.
//

#import "ViewController.h"
#import "EAIntroView.h"
#import "EAIntroViewWelcome.h"


@interface ViewController ()
- (IBAction)click:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([Common isFirstLogin]) {
        EAIntroViewWelcome *welcome = [[EAIntroViewWelcome alloc] init];
        [welcome show:(id)self type:WelcomeStyle_CrossDissolve];
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
   
}
@end
