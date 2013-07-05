//
//  UserSetting.m
//  ProjectListening
//
//  Created by zhaozilong on 13-4-20.
//
//

#import "UserSetting.h"
#import "AssInfoClass.h"
#import "StudyTimeInfoClass.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "cocos2d.h"
#import "NSDate+ZZDate.h"
#import "UserInfo.h"

@implementation UserSetting

#pragma mark - Nothing
+ (void)NOTHING {
    
}

#pragma mark - Feedback Methods
#define kUserEmail @"kUserEmail"

+ (BOOL)isUserEmail {
    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:kUserEmail];
    
    if (email && ![email isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)userEmail {
    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:kUserEmail];
    
    return email;
}

+ (void)setUserEmail:(NSString *)email {
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:kUserEmail];
}

+ (void)setUserAdviseMsgArray:(NSMutableArray *)messageArray {
    NSString *path = [ZZAcquirePath getDocDirectoryWithFileName:PLIST_NAME_USERADVISE];
    
    NSMutableArray *mArray = [NSMutableArray arrayWithContentsOfFile:path];
    for (NSMutableDictionary *dic in mArray) {
        [messageArray addObject:dic];
    }
}

+ (void)writeUserAdviseToPlist:(NSMutableArray *)messageArray {
    NSString *path = [ZZAcquirePath getDocDirectoryWithFileName:PLIST_NAME_USERADVISE];
    
    [messageArray writeToFile:path atomically:YES];
}

#pragma mark - First Time Run 
//此版本是否第一次运行
+ (BOOL)isThisVersionFirstTimeRun {
    BOOL  hasRunBefore = [[NSUserDefaults standardUserDefaults] boolForKey:kApplicationVersion];
    
    if (!hasRunBefore) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kApplicationVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    
    return NO;
}

//程序是否第一次安装运行
#define kIsFirstTimeInstall @"kIsFirstTimeInstall"
+ (BOOL)isFirstTimeInstallApplication {
    BOOL  hasRunBefore = [[NSUserDefaults standardUserDefaults] boolForKey:kIsFirstTimeInstall];
    if (!hasRunBefore) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsFirstTimeInstall];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    
    return NO;
}

#pragma mark - First View

#define kIsStartOfEverythingNew @"kIsStartNew"
+ (BOOL)isStartOfEverythingNew {
    BOOL isStart = [[NSUserDefaults standardUserDefaults] boolForKey:kIsStartOfEverythingNew];
    if (!isStart) {
#if COCOS2D_DEBUG
        NSLog(@"还没选择助理和学习时间");
#endif
        return YES;
    }
    
    return NO;
}

+ (void)setStartOfEverythingNewFalse {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsStartOfEverythingNew];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Progress

#define kAssistantID @"kAssistantID"
+ (void)setAssistantID:(int)num {
    [[NSUserDefaults standardUserDefaults] setInteger:num forKey:kAssistantID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)assistantID {
    int number = [[NSUserDefaults standardUserDefaults] integerForKey:kAssistantID];
    return number;
}

+ (void)removeAssistantTextureExcept:(int)assID {
    switch (assID) {
        case 0:
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"AssistantID_1.plist"];
            [[CCTextureCache sharedTextureCache] removeUnusedTextures];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AssistantID_0.plist"];
            break;
            
        case 1:
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"AssistantID_0.plist"];
            [[CCTextureCache sharedTextureCache] removeUnusedTextures];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AssistantID_1.plist"];
            break;
            
        default:
            NSAssert(NO, @"清除内存纹理图册ERROR");
            break;
    }
}

#define kStudyTime @"kStudyTime"
+ (void)setStudyTime:(int)seconds {
    [[NSUserDefaults standardUserDefaults] setInteger:seconds forKey:kStudyTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)studyTime {
    int number = [[NSUserDefaults standardUserDefaults] integerForKey:kStudyTime];
    return number;
}

#define kIsNeedPurchase @"kIsNeedPurchase"
+ (void)setIsNeedPurchase:(BOOL)isNeed {
    
    [[NSUserDefaults standardUserDefaults] setBool:isNeed forKey:kIsNeedPurchase];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isNeedPurchase {
    BOOL isPurchase = [[NSUserDefaults standardUserDefaults] boolForKey:kIsNeedPurchase];
    return isPurchase;
    
}

#define kIsNeedRate @"kIsNeedRate"
+ (void)setIsNeedRate:(BOOL)isRate {
    [[NSUserDefaults standardUserDefaults] setBool:isRate forKey:kIsNeedRate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isNeedRate {
    BOOL isRate = [[NSUserDefaults standardUserDefaults] boolForKey:kIsNeedRate];
    return isRate;
}

#define kIsNeedFeedback @"kIsNeedFeedback"
+ (void)setIsNeedFeedback:(BOOL)isFeedBack {
    [[NSUserDefaults standardUserDefaults] setBool:isFeedBack forKey:kIsNeedFeedback];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isNeedFeedback {
    BOOL isFeedBack = [[NSUserDefaults standardUserDefaults] boolForKey:kIsNeedFeedback];
    return isFeedBack;
}

#define kOpenTimes @"kOpenTimes"
+ (void)setOpenTimes:(int)times {
    [[NSUserDefaults standardUserDefaults] setInteger:times forKey:kOpenTimes];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)OpenTimes {
    int times = [[NSUserDefaults standardUserDefaults] integerForKey:kOpenTimes];
    return times;
}

#define kIsTodayFirstTimeOpen @"kIsTodayFirstTimeOpen"
+ (void)setIsTodayFirstTimeOpen:(BOOL)isFirst {
    [[NSUserDefaults standardUserDefaults] setBool:isFirst forKey:kIsTodayFirstTimeOpen];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isTodayFirstTimeOpen {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsTodayFirstTimeOpen];
}



#pragma mark - AssistantPlist
#define kAssID @"kAssID"
#define kAssCName @"kAssCName"
#define kAssJName @"kAssJName"
#define kAssEName @"kAssEName"
#define kAssCInfo @"kAssCInfo"
#define kAssJInfo @"kAssJInfo"
#define kAssEInfo @"kAssEInfo"
#define kAssImgName @"kAssImgName"
//把plist中的字典转化成类存入数组中
+ (void)setAssInfoArray:(NSMutableArray *)AICArray {
    NSString *path = [ZZAcquirePath getPlistAssistantFromBundle];
    NSMutableArray *assArray = [NSMutableArray arrayWithContentsOfFile:path];
    
    for (NSMutableDictionary *dic in assArray) {
        int aID = [[dic objectForKey:kAssID] intValue];
        //在此处本地化一下子
        NSString *aName = [dic objectForKey:kAssCName];
        NSString *aInfo = [dic objectForKey:kAssCInfo];
        NSString *imgName = [dic objectForKey:kAssImgName];
        AssInfoClass *AIC = [AssInfoClass assInfoWithID:aID name:aName info:aInfo imgName:imgName];
        [AICArray addObject:AIC];
    }

}

#define kStudyTime @"kStudyTime"
#define kStudyTimeImg @"kStudyTimeImg"
#define kStudyTimeInfoCN @"kStudyTimeInfoCN"
#define kStudyTimeInfoEN @"kStudyTimeInfoEN"
#define kStudyTimeInfoJP @"kStudyTimeInfoJP"
//把plist中的字典转化成类存入数组中
+ (void)setStudyTimeInfoArray:(NSMutableArray *)STICArray {
    NSString *path = [ZZAcquirePath getPlistStudyTimeFromBundle];
    NSMutableArray *studyTimeArray = [NSMutableArray arrayWithContentsOfFile:path];
    
    for (NSMutableDictionary *dic in studyTimeArray) {
        int time = [[dic objectForKey:kStudyTime] intValue];
        NSString *imgName = [dic objectForKey:kStudyTimeImg];
        //在此处本地化一下子
        NSString *timeinfo = [dic objectForKey:kStudyTimeInfoCN];
        StudyTimeInfoClass *STIC = [StudyTimeInfoClass studyTimeInfoWithTime:time img:imgName timeInfo:timeinfo];
        
        [STICArray addObject:STIC];
    }
    
}

#define kPurchaseNum @"kPurchaseNum"
+ (void)setPurchaseNum:(int)num {
    [[NSUserDefaults standardUserDefaults] setInteger:num forKey:kPurchaseNum];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)purchaseNum {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kPurchaseNum];
}

+ (int)totalPurchaseNum {
    NSString *path = [ZZAcquirePath getPlistProductsFromBundle];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
    int count = array.count;
    if (count > 1) {
        count--;
    }
    return count;
}

#define kPurchaseVIPMode @"kPurchaseVIPMode"
+ (BOOL)isPurchasedVIPMode {
    BOOL isVipMode = [[NSUserDefaults standardUserDefaults] boolForKey:kPurchaseVIPMode];
    
    if (isVipMode || IS_PRO_Ver) {//内购购买应用的VIP的用户或者是Pro版本的用户
        return YES;
    } else if ([UserInfo isVIPValid]) {//爱语吧VIP会员
        return YES;
    } else if ([TestType isToefl] && [UserSetting purchaseNum] < 2) {//托福以前购买过题目的人
        return YES;
    } else {
        return NO;
    }
}

+ (void)setPurchaseVIPMode:(BOOL)isVipMode {
    [[NSUserDefaults standardUserDefaults] setBool:isVipMode forKey:kPurchaseVIPMode];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Study View Settings
#define kSyncTextColor @"mulValueColor"
+ (UIColor *)syncTextColor {
    
    //红色
    UIColor *color = [UIColor colorWithRed:0.827f green:0.051f blue:0.270f alpha:1];
    
    NSInteger colorIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"mulValueColor"];
    switch (colorIndex) {
        case 2:
            //橘黄
            color = [UIColor colorWithRed:1.0f green:0.259f blue:0.0f alpha:1];
            break;
            
        case 3:
            //紫色
            color = [UIColor colorWithRed:0.557f green:0.047f blue:0.576f alpha:1];
            break;
            
        case 4:
            //绿色
            color = [UIColor colorWithRed:0.212f green:0.533f blue:0.0f alpha:1];
            break;
            
        case 5:
            //蓝色
            color = [UIColor colorWithRed:0.055f green:0.008f blue:0.529f alpha:1];
            break;
            
        default:
            break;
    }
    
    return color;
}

#define kTextFontSize @"mulValueFont"
+ (int)textFontSizeFake {
    
    int fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:kTextFontSize];
    
    if (fontSize > 0) {
        fontSize = fontSize + 1;
        return fontSize;
    }
    return (DefaultRealFontSize + 1);
}

+ (int)textFontSizeReal {
    
    int fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:kTextFontSize];
    
    if (fontSize > 0) {
        return fontSize;
    }
    
    return DefaultRealFontSize;
}

#define kTextShowStyle @"mulValueTextShowStyle"
+ (TextShowStyleTags)textShowStyle {
    
    TextShowStyleTags showStyle = [[NSUserDefaults standardUserDefaults] integerForKey:kTextShowStyle];
    
    
    
    switch (showStyle) {
        case TextShowStyleAll:
            showStyle = TextShowStyleAll;
            break;
            
        case TextShowStyleNone:
            showStyle = TextShowStyleNone;
            break;
        case TextShowStylePart:
        default:
            showStyle = TextShowStylePart;
            break;
    }
    
    return showStyle;
}

#define kKeepScreenLight @"keepScreenLight"

+ (void)setScreenKeepLight:(BOOL)isLight {
    [[NSUserDefaults standardUserDefaults] setBool:isLight forKey:kKeepScreenLight];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)screenKeepLightStatus {
    //设置屏幕常亮onOrOff
    BOOL isLight = [[NSUserDefaults standardUserDefaults] boolForKey:kKeepScreenLight];
    return isLight;
}

#define kKeepTextSync @"keepTextSync"
+ (void)setTextKeepSync:(BOOL)isSync {
    [[NSUserDefaults standardUserDefaults] setBool:isSync forKey:kKeepTextSync];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)textKeepSync {
    BOOL isSync = [[NSUserDefaults standardUserDefaults] boolForKey:kKeepTextSync];
    return isSync;
}

#define kSwipeGesture @"SwipeGesture"
+ (BOOL)isSwipeGestureEnabled {
    BOOL isSwipeGesture = [[NSUserDefaults standardUserDefaults] boolForKey:kSwipeGesture];
    return isSwipeGesture;
}

+ (void)setSwipeGestureEnabled:(BOOL)isEnabled {
    [[NSUserDefaults standardUserDefaults] setBool:isEnabled forKey:kSwipeGesture];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#define kPushDate @"pushDate"
#define kIsPushDate @"IsPushDate"
#define kHasRunPushDate @"HasRunPushDate"
+ (NSString *)stringForPushDate:(NSDate *)date {
    //本地化一下子
//    NSDate *date = [UserSetting pushDate];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *time = [formatter stringFromDate:date];
    
    return time;
}

+ (int)hourForPushDate:(NSArray *)dateArray {

    NSString *hourStr = [dateArray objectAtIndex:1];
    NSArray *hourArray = [hourStr componentsSeparatedByString:@":"];
    int hour = [[hourArray objectAtIndex:0] intValue];
    return hour;
}

+ (NSString *)minuteForPushDate:(NSArray *)dateArray {

    NSString *hourStr = [dateArray objectAtIndex:1];
    NSArray *hourArray = [hourStr componentsSeparatedByString:@":"];
    int min = [[hourArray objectAtIndex:1] intValue];
    return min;
}

+ (NSDate *)pushDate {
    
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:kPushDate];
//    date = nil;
    //默认值
    if (date == nil) {
        NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
        [components setHour:20];
        //本地化一下子
        NSCalendar *localCalendar = [NSCalendar currentCalendar];
//        NSCalendar *localCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
        
        date = [localCalendar dateFromComponents:components];
        [UserSetting setPushDate:date];
        
//        NSString *dateStr=@"0001-01-01 20:00:00";//传入时间
//        //将传入时间转化成需要的格式
//        NSDateFormatter *format=[[NSDateFormatter alloc] init];
//        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSDate *fromdate=[format dateFromString:dateStr];
////        NSTimeZone *fromzone = [NSTimeZone localTimeZone];
////        NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
////        NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
//        NSLog(@"fromdate=%@",[NSDate getLocateDate:fromdate]);
//        [format release];
//        //获取当前时间
//        NSDate *date = [NSDate date];
//        NSTimeZone *zone = [NSTimeZone systemTimeZone];
//        NSInteger interval = [zone secondsFromGMTForDate: date];
//        NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//        NSLog(@"enddate=%@",localeDate);
    }
    return date;
}

+ (void)setPushDate:(NSDate *)date {
    
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:kPushDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)pushHourAndMinAndAMPM {
    
    NSString *hourAndMin = [[NSUserDefaults standardUserDefaults] objectForKey:kPushDate];
//    hourAndMin=  nil;
    //默认值
    if (hourAndMin == nil) {
        hourAndMin = @"8:00:PM";
        [UserSetting setPushHour:@"8" min:@"00" amOrPm:@"PM"];
    }
    return [hourAndMin componentsSeparatedByString:@":"];
}

+ (void)setPushHour:(NSString *)hour min:(NSString *)min amOrPm:(NSString *)amOrpm {
    
//    int hour24 = [hour integerValue];
//    if ([amOrpm isEqualToString:@"PM"]) {
//        hour24 += 12;
//    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@:%@:%@", hour, min, amOrpm] forKey:kPushDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isPushDate {
    BOOL isHasRunPushDate = [[NSUserDefaults standardUserDefaults] boolForKey:kHasRunPushDate];
    BOOL isPushDate = [[NSUserDefaults standardUserDefaults] boolForKey:kIsPushDate];
    if (!isHasRunPushDate) {
        isPushDate = YES;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kHasRunPushDate];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsPushDate];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } 
    return isPushDate;
}

+ (void)setIsPushDate:(BOOL)isPushDate {
    [[NSUserDefaults standardUserDefaults] setBool:isPushDate forKey:kIsPushDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Device Info

+ (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *) platformString{
    NSString *platform = [UserSetting platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone5";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPodTouch1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad3";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad4";
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])         return @"iPhoneSimulator";
    return platform;
}

+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)applicationVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(infoDictionary);
    // app名称
//    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return app_Version;
}

+ (NSString *)buildVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(infoDictionary);
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_build;
}


@end
