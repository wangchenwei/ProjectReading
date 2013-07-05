//
//  TitleInfoClass.h
//  ProjectListening
//
//  Created by zhaozilong on 13-4-16.
//
//

#import <Foundation/Foundation.h>

@interface TitleInfoClass : NSObject

@property (nonatomic, retain) NSString *titleName;
@property (nonatomic, retain) NSString *soundTime;
@property (assign) int titleNum;
@property (assign) int quesNum;
@property (assign) int rightNum;

+ (TitleInfoClass *)titleInfoWithTitleName:(NSString *)name titleNum:(int)titleNum quesNum:(int)quesNum soundTime:(int)soundTime rightNum:(int)rightNum;

@end
