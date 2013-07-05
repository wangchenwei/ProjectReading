//
//  TitleInfoClass.m
//  ProjectListening
//
//  Created by zhaozilong on 13-4-16.
//
//

#import "TitleInfoClass.h"
#import "NSString+ZZString.h"

@implementation TitleInfoClass

- (void)dealloc {
    
//    [self.titleName release], self.titleName = nil;
//    [self.soundTime release], self.soundTime = nil;
    [super dealloc];
}

+ (TitleInfoClass *)titleInfoWithTitleName:(NSString *)name titleNum:(int)titleNum quesNum:(int)quesNum soundTime:(int)soundTime rightNum:(int)rightNum  {
    
    return [[[self alloc] initWithTitleName:name titleNum:titleNum quesNum:quesNum soundTime:soundTime rightNum:rightNum] autorelease];
}

- (id)initWithTitleName:(NSString *)name titleNum:(int)titleNum quesNum:(int)quesNum soundTime:(int)soundTime rightNum:(int)rightNum {
    
    self = [super init];
    if (self) {
        
        self.titleName = name;
        self.soundTime = [NSString hmsToSwitchAdvance:soundTime];
        self.titleNum = titleNum;
        self.quesNum = quesNum;
        self.rightNum = rightNum;
        
    }
    
    return self;
}


@end
