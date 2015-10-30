//
//  FirstView.m
//  UniversalView
//
//  Created by wangxian on 15/10/30.
//  Copyright © 2015年 wangxian. All rights reserved.
//

#import "FirstView.h"

@implementation FirstView

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    
    if(self = [super initWithCoder:aDecoder])
    {
        
        
    }
    return self;
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_reuse = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_reuse];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%这是第：%ld 行",indexPath.row];
    return cell;
    
}
-(void)initView{
    [self.m_tableView setBackgroundColor:[UIColor yellowColor]];
    self.m_tableView.delegate = (id)self;
    self.m_tableView.dataSource = (id)self;
    
}

-(void)RefeshView{
    [self.m_tableView reloadData];

}

@end
