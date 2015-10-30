//
//  Common.h
//  YouPaoPao
//
//  Created by wangxian on 15/6/4.
//  Copyright (c) 2015年 DX-YF. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IS_IPHONE1 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)//iPhone 1、3G、3GS，iPod Touch 1、2、3

#define IS_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)//iPhone 4、4S，iPod Touch 4
//判断设备是否IPHONE5
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)//iPhone 5，iPod Touch 5

#define IS_IPAD2 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)//iPad 1， iPad2，iPad mini

#define IS_IPAD3 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)//New iPad，iPad 4


#define Screen_height  [[UIScreen mainScreen] bounds].size.height
#define Screen_width  [[UIScreen mainScreen] bounds].size.width


@interface Common : NSObject
@property (strong, nonatomic) UIViewController *currentViewController;
+(Common *)singleton;
//全局的入口
@property (nonatomic, strong) UINavigationController *m_globalNav;
@property BOOL isInstallQQ;

+(void)showMessage:(NSString *)message;
-(void)NavigationBack:(id)who;
-(NSString *)ReturnUserId;
-(NSString *)GetUserName;
-(NSString *)ChangeDistanceToString:(float)distance;
-(NSString *)GetAgeAndSex:(NSInteger)age Sex:(NSString *)sex; //获取性别和年龄
-(NSString *)GetTime:(NSString *)time;//获取时间间隔
-(NSString *)GetCreatTime:(NSString *)time;//获取时间
-(NSString *)Getlatitude;//获取纬度
-(NSString *)Getlongitude;//获取经度
+(double)ToGaodeLat:(double)lat;
+(double)ToGaodeLong:(double)longitude;
+(BOOL)IsSetPhoneNum;
+(void)SetPhoneNum:(NSString *)phone;
+(NSString *)GetPhoneNum;
//根据messageid 获取字典
-(NSMutableDictionary *)GetDictionaryFromMessageId:(NSString *)messageid;

////用它来压缩图片
-(UIImage *)ImageScale:(UIImage *)img;

-(NSInteger)GetGroupIsHideName:(NSString *)hxgroupid;
-(void)SetGroupisHideName:(NSString *)groupid isHide:(NSString *)ishide;

-(NSString *)GetImgUrl:(NSArray *)array;
+ (BOOL) isNull:(NSString *) astr;
+(NSMutableArray *)SplitStringWithSpace:(NSString *)str;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(NSString *)GetMessageFromJsonString:(NSString *)str;
///上传坐标
-(void)SetZuobiao;
///匹配图片
+(NSString *)GetImgPathFromUrl:(NSString *)str replaceString:(NSString *)replace;
+(void)Config:(NSString *)configrule;
+(NSString*)getTimeAndRandom;
+(void)CheckIsHaveUpdate;

+(BOOL)isFirstLogin;
+(void)ViewOffset:(UIView *)v;
+(void)ViewPianyi:(UIView *)v;
@end
