//
//  UserSetting.h
//  ProjectListening
//
//  Created by zhaozilong on 13-4-20.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    TextShowStylePart,
    TextShowStyleAll,
    TextShowStyleNone,
}TextShowStyleTags;

@interface UserSetting : NSObject

+ (BOOL)isUserEmail;
+ (void)setUserEmail:(NSString *)email;
+ (NSString *)userEmail;

+ (void)setUserAdviseMsgArray:(NSMutableArray *)messageArray;
+ (void)writeUserAdviseToPlist:(NSMutableArray *)messageArray;

+ (BOOL)isThisVersionFirstTimeRun;
+ (BOOL)isFirstTimeInstallApplication;

+ (BOOL)isStartOfEverythingNew;
+ (void)setStartOfEverythingNewFalse;

+ (void)removeAssistantTextureExcept:(int)assID;
+ (void)setAssistantID:(int)num;
+ (int)assistantID;
+ (void)setStudyTime:(int)seconds;
+ (int)studyTime;
+ (void)setIsNeedPurchase:(BOOL)isNeed;
+ (BOOL)isNeedPurchase;
+ (void)setIsNeedRate:(BOOL)isRate;
+ (BOOL)isNeedRate;
+ (void)setIsNeedFeedback:(BOOL)isFeedBack;
+ (BOOL)isNeedFeedback;
+ (void)setOpenTimes:(int)times;
+ (int)OpenTimes;
+ (void)setIsTodayFirstTimeOpen:(BOOL)isFirst;
+ (BOOL)isTodayFirstTimeOpen;

+ (void)setAssInfoArray:(NSMutableArray *)AICArray;
+ (void)setStudyTimeInfoArray:(NSMutableArray *)STICArray;
+ (void)setPurchaseNum:(int)num;
+ (int)purchaseNum;
+ (int)totalPurchaseNum;
+ (BOOL)isPurchasedVIPMode;
+ (void)setPurchaseVIPMode:(BOOL)isVipMode;

+ (UIColor *)syncTextColor;
+ (int)textFontSizeFake;
+ (int)textFontSizeReal;
+ (TextShowStyleTags)textShowStyle;
+ (void)setScreenKeepLight:(BOOL)isLight;
+ (BOOL)screenKeepLightStatus;
+ (void)setTextKeepSync:(BOOL)isSync;
+ (BOOL)textKeepSync;
+ (BOOL)isSwipeGestureEnabled;
+ (void)setSwipeGestureEnabled:(BOOL)isEnabled;

//+ (NSString *)stringForPushDate:(NSDate *)date;
//+ (NSDate *)pushDate;
//+ (void)setPushDate:(NSDate *)date;
+ (NSArray *)pushHourAndMinAndAMPM;
+ (void)setPushHour:(NSString *)hour min:(NSString *)min amOrPm:(NSString *)amOrpm;
+ (BOOL)isPushDate;
+ (void)setIsPushDate:(BOOL)isPushDate;

//+ (int)hourForPushDate:(NSArray *)dateArray;
//+ (NSString *)minuteForPushDate:(NSArray *)dateArray;

//+ (NSString *)platform;
+ (NSString *)platformString;
+ (NSString *)systemVersion;
+ (NSString *)applicationVersion;

@end
