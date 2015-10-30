//
//  Common.m
//  YouPaoPao
//
//  Created by wangxian on 15/6/4.
//  Copyright (c) 2015年 DX-YF. All rights reserved.
//

#import "Common.h"
@implementation Common
static Common *Common_Singleton = nil;
+ (Common *)singleton
{
    if (nil == Common_Singleton)
    {
        @synchronized(self){ //添加锁确保线程安全
            Common_Singleton = [[Common alloc] init];
        }
    }
    return Common_Singleton;
}

-(void)NavigationBack:(id)who{
    UIViewController * whos = (UIViewController *)who;
    self.currentViewController = whos;
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [back setFrame:CGRectMake(0, 0,20, 20)];
    [back addTarget:self action:@selector(onClcikBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    whos.navigationItem.leftBarButtonItem = backButtonItem;
}

-(void)onClcikBack:(id)sender{
    [self.currentViewController.navigationController popViewControllerAnimated:YES];
}

-(NSString *)ReturnUserId{
    NSDictionary * tem = [[NSUserDefaults standardUserDefaults]objectForKey:@"session"];
    NSString *userid = [tem valueForKey:@"userid"];
    if (userid == nil) {
        userid = @"";
    }
    //userid = @"10012"; //此值为测试使用数据，真实应用需要去掉
    return userid;
}


-(NSString *)GetUserName
{
    //NSDictionary * tem = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    if (userName == nil) {
        userName = @"";
    }
    return userName;
}


-(NSString *)ChangeDistanceToString:(float)distance{
    if (distance > 5500000) {
        return @"未知";
    }
    if (distance > 1000) {
        float l = (distance/1000);
        return [NSString stringWithFormat:@"%0.3f km",l];
    }
    else{
        
        if (distance < 100) {
            return @"100m以内";
        }
        return [NSString stringWithFormat:@"%0.0f m",distance];
    }
    
}

-(NSString *)GetAgeAndSex:(NSInteger)age Sex:(NSString *)sex{
    NSString * age_sex;
    NSString *temSex;
    if ([sex isEqualToString:@"女"]) {
        temSex = @"♀";
    }
    else if([sex isEqualToString:@"♀女"]){
        temSex = @"♀";
    }
    else if([sex isEqualToString:@"男"]){
        temSex = @"♂";
    }
    else if([sex isEqualToString:@"♂男"]){
        temSex = @"♂";
    }
    else{
        temSex = @"";
    }
    
    age_sex = [NSString stringWithFormat:@"%@ %ld",temSex, age];
    return age_sex;
    
}
-(NSString *)GetTime:(NSString *)time{
    NSDate *  senddate = [NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    time = [time stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    NSDate *date2 = [dateformatter dateFromString:time];
    NSTimeInterval time1 = [senddate timeIntervalSinceDate:date2];
    NSString *tem;
    int Minute = (int)time1/60;
    Minute = abs(Minute);
    if (Minute < 59) {
        tem = [NSString stringWithFormat:@"%d 分钟前", Minute];
    }
    if (Minute > 59) {
        int hour = Minute/60;
        if (hour < 24) {
             tem = [NSString stringWithFormat:@"%d 小时前", hour];
        }
        else{
             tem = [NSString stringWithFormat:@"%d 天前", hour/24];
        }
    }
    
    return tem;
}

-(NSString *)GetCreatTime:(NSString *)time{

        NSString * result = [time stringByReplacingOccurrencesOfString:@"T" withString:@" "]; //字符串替换
        for (int i = 0; i<[result length]; i++) {
            //截取字符串中的每一个字符
            NSString *s = [result substringWithRange:NSMakeRange(i, 1)];
            NSLog(@"string is %@",s);
            if ([s isEqualToString:@"."]) {
               // NSRange range = NSMakeRange(i, 1);
                //将字符串中的“m”转化为“w”
                result =   [time substringToIndex:i]; //截取到第几位
                break;
                
            }
        }
        return result;
}

//提示框
+(void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width - 20)/2, SCREEN_HEIGHT - 100, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:3.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

///获取纬度
-(NSString *)Getlatitude
{
    
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"btsLat_temp"];  // forKey:@"btsLat_temp"];
    if (latitude == nil) {
        latitude = @"38";
    }
    return  [NSString stringWithFormat:@"%lf",latitude.doubleValue + 0.0060]; //转换为百度坐标
}
///获取经度
-(NSString *)Getlongitude
{
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"btsLon_temp"]; //
    if (longitude == nil) {
        longitude = @"112";
    }
    return [NSString stringWithFormat:@"%lf",longitude.doubleValue + 0.0065];//转换为百度坐标
    
}
//转换为高德坐标
+(double)ToGaodeLat:(double)lat{
    double temp = lat - 0.0060;
    if (temp < 0) {
        temp = 0;
    }
    return temp;
}
+(double)ToGaodeLong:(double)longitude{
    double temp = longitude - 0.0065;
    if (temp < 0) {
        temp = 0;
    }
    return temp;
}


-(NSMutableDictionary *)GetDictionaryFromMessageId:(NSString *)messageid{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:messageid]];
    return dic;
    
}


-(UIImage *)ImageScale:(UIImage *)img
{
    
    CGSize newSize = CGSizeMake(150, 150);
    newSize.height = img.size.height*(newSize.width/img.size.width);
    UIGraphicsBeginImageContext(newSize);//获取绘画环境（相当于新建一个newSize大小的画布）
    [img drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];//绘制图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当天绘画环境中获取图片对象（相当于截图了）
    UIGraphicsEndImageContext();//结束绘画
    return  newImage;
}


//-(UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
//    CGSize newSize = CGSizeMake(150, 150);
//    newSize.height = image.size.height*(newSize.width/image.size.width);
//    UIGraphicsBeginImageContext(newSize);//获取绘画环境（相当于新建一个newSize大小的画布）
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];//绘制图片
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当天绘画环境中获取图片对象（相当于截图了）
//    UIGraphicsEndImageContext();//结束绘画
//    return  newImage;
//    
//}


-(NSInteger)GetGroupIsHideName:(NSString *)hxgroupid
{
    NSInteger ret;
    if (hxgroupid < 0) {
        return 0;
    }
    else
    {
        NSString *isHide = [[NSUserDefaults standardUserDefaults] objectForKey:hxgroupid];
        if (!isHide) {
            ret = 1;
        }
        else
        {
            ret = [isHide integerValue];
        }
    }
    return ret;
}


-(void)SetGroupisHideName:(NSString *)groupid isHide:(NSString *)ishide
{
    
    [[NSUserDefaults standardUserDefaults] setObject:ishide forKey:groupid];
}




-(NSString *)GetImgUrl:(NSArray *)array{
    NSMutableString *str = @"";
    for (int i = 0;  i < array.count;  i++) {
        NSString *temp = [array objectAtIndex:i];
        if (i != array.count - 1)
        {
            str = [NSMutableString stringWithFormat:@"%@,", temp];

        }
        else
        {
            str = [NSMutableString stringWithFormat:@"%@", temp];
        }
    }
    return str;
}

+ (BOOL) isNull:(NSString *) astr{
    if (!astr || [[NSString stringWithFormat:@"%@", astr] isEqualToString:@"<null>"]
        || [[NSString stringWithFormat:@"%@", astr] isEqualToString:@""]
        || [[NSString stringWithFormat:@"%@", astr] isEqualToString:@"{}"] //由空值字典转换过来的字符串， 判断字典为空。
        || [[NSString stringWithFormat:@"%@", astr] isEqualToString:@"0.0"] //getValue 返回的空值
        || (NSNull *)astr == [NSNull null]) {
        return YES;
    }else{
        return NO;
    }
}

+(NSMutableArray *)SplitStringWithSpace:(NSString *)str{
    
    NSArray *list = [str componentsSeparatedByString:@" "];
    NSMutableArray *array = [NSMutableArray arrayWithArray:list];
    return array;
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



+(NSString *)GetMessageFromJsonString:(NSString *)str{
    
    NSArray *list = [str componentsSeparatedByString:@":"];
    NSString *temp = [list lastObject];
    if (!temp) {
        temp = @"";
    }
    temp = [temp stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return str;
    
}





+(NSString *)GetImgPathFromUrl:(NSString *)str replaceString:(NSString *)replace{
    NSString *temp = @"";
    if (str == nil) {
        return temp;
    }
    NSString *result = @"";
    
//    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:
//                                              
//                                              @"^.*?\.(jpg|jpeg|bmp|gif|png)$ " options:0 error:nil];
//    if (regularExpression != nil) {
//        NSTextCheckingResult *firstMatch = [regularExpression firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
//        
//        if (firstMatch) {
//            NSRange resultRange = [firstMatch rangeAtIndex:0]; //等同于 firstMatch.range --- 相匹配的范围
//            //从urlString当中截取数据
//            result = [str substringWithRange:resultRange];
//            //输出结果
//            NSLog(@"%@",result);
//        }
//    } +\.doc
    
//    NSString *regexString  = @"+\.(jpg|jpeg|bmp|gif|png)$";
    if ([str rangeOfString:@".png"].location != NSNotFound) {
        result = @".png";
    }
    else if([str rangeOfString:@".bmp"].location != NSNotFound){
        result = @".bmp";
    }
    else if([str rangeOfString:@".gif"].location != NSNotFound){
        result = @".gif";
    }
    else if([str rangeOfString:@".jpg"].location != NSNotFound){
        result = @".jpg";
    }
    NSString *replaceStr = [NSString stringWithFormat:@"%@%@",replace,result];
    temp  = [str stringByReplacingOccurrencesOfString:result withString:replaceStr];
    return temp;
}



// 当前时间+随机数
+(NSString*)getTimeAndRandom{
    int iRandom=arc4random();
    if (iRandom<0) {
        iRandom=-iRandom;
    }
    
    NSDateFormatter *tFormat=[[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *tResult=[NSString stringWithFormat:@"%@%d",[tFormat stringFromDate:[NSDate date]],iRandom];
    return tResult;
}

//是否设置了手机号码
+(BOOL)IsSetPhoneNum{
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    if ([phone isEqualToString:@"0"]) {
        return NO;
    }
    return YES;
}

+(void)SetPhoneNum:(NSString *)phone{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
}
+(NSString *)GetPhoneNum{
   return  [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
}


+(BOOL)isFirstLogin{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        return YES;
    }
    else{
        return NO;
        
    }
}

+(void)ViewOffset:(UIView *)v{
    
    [UIView beginAnimations:@"doflip" context:nil];
    //设置时常
    [UIView setAnimationDuration:1];
    //设置动画淡入淡出
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置翻转方向
    [UIView setAnimationTransition:
     UIViewAnimationTransitionFlipFromLeft  forView:v cache:YES];
    //动画结束
    [UIView commitAnimations];
}

+(void)ViewPianyi:(UIView *)v{
    CGAffineTransform  transform;
    //设置旋转度数
    transform = CGAffineTransformRotate(v.transform, M_PI/2.0);
    //动画开始
    [UIView beginAnimations:@"rotate" context:nil ];
    //动画时常
    [UIView setAnimationDuration:10];
    //添加代理
    [UIView setAnimationDelegate:self];
    //获取transform的值
    [v setTransform:transform];
    //关闭动画
    [UIView commitAnimations];
}



@end
