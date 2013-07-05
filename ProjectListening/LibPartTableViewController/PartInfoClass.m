//
//  PartInfoClass.m
//  ToeflListening
//
//  Created by zhaozilong on 13-6-1.
//
//

#import "PartInfoClass.h"

@implementation PartInfoClass

+ (PartInfoClass *)partInfoWithPackName:(NSString *)packName partType:(PartTypeTags)partType titleNum:(int)titleNum rightNum:(int)rightNum  {
    
    return [[[self alloc] initWithPackName:packName partType:partType titleNum:titleNum rightNum:rightNum] autorelease];
}

- (id)initWithPackName:(NSString *)packName partType:(PartTypeTags)partType titleNum:(int)titleNum rightNum:(int)rightNum {
    
    self = [super init];
    if (self) {
        
        self.packName = packName;
        self.partType = partType;
        self.titleNumOfPart = titleNum;
        self.rightNumOfPart = rightNum;
        
    }
    
    return self;
}

@end
