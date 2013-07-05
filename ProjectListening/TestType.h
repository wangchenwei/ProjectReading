//
//  TestType.h
//  ProjectListening
//
//  Created by zhaozilong on 13-5-20.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    TestTypeToeic = 101,
    TestTypeToefl = 102,
    TestTypeJLPT1 = 111,
    TestTypeJLPT2 = 112,
    TestTypeJLPT3 = 113,
    TestTypeMAX,
}TestTypeTags;

typedef enum {
    PartType201 = 201,
    PartType202,
    PartType203,
    PartType301 = 301,
    PartType302,
    PartType303,
    PartType304,
    PartType305,//有图文字题 暂时空
    PartType306,//问题1
    PartType307,//问题2
    PartType308,//问题3
    PartType309,//问题4
    PartType310,//问题5
    PartType401 = 401,
    PartType402,
    PartType403,
    PartType404,
    PartTypeMAX,
}PartTypeTags;

@interface TestType : NSObject

+ (BOOL)isJapaneseTest;
+ (BOOL)isEnglishTest;

+ (BOOL)isJLPT;
+ (BOOL)isToefl;
+ (BOOL)isToeic;

+ (UIColor *)colorWithTestType;
+ (NSString *)partNameWithPartType:(PartTypeTags)partType;

@end
