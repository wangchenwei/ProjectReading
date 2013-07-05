//
//  TestType.m
//  ProjectListening
//
//  Created by zhaozilong on 13-5-20.
//
//

#import "TestType.h"

@implementation TestType

+ (BOOL)isJapaneseTest {
    return (TEST_TYPE == TestTypeJLPT1 || TEST_TYPE == TestTypeJLPT2 || TEST_TYPE == TestTypeJLPT3);
}

+ (BOOL)isEnglishTest {
    return (TEST_TYPE == TestTypeToefl || TEST_TYPE == TestTypeToeic);
}

+ (BOOL)isJLPT {
    
    return (TEST_TYPE == TestTypeJLPT1 || TEST_TYPE == TestTypeJLPT2 || TEST_TYPE == TestTypeJLPT3);
}

+ (BOOL)isJLPTN1{
    
    return (TEST_TYPE == TestTypeJLPT1);
}

+ (BOOL)isJLPTN2{
    
    return (TEST_TYPE == TestTypeJLPT2);
}

+ (BOOL)isJLPTN3{
    
    return (TEST_TYPE == TestTypeJLPT3);
}

+ (BOOL)isToefl {
    return (TEST_TYPE == TestTypeToefl);
}

+ (BOOL)isToeic {
    return (TEST_TYPE == TestTypeToeic);
}

+ (UIColor *)colorWithTestType {
    UIColor *color = nil;
//    CGFloat cRed = 0.0, cGreen = 0.0, cBlue = 0.0;
    TestTypeTags testTypeTag = TEST_TYPE;
    switch (testTypeTag) {
        case TestTypeJLPT1:
            color = [UIColor colorWithRed:0.102 green:0.702 blue:0.533 alpha:1.0];
            break;
            
        case TestTypeJLPT2:
            color = [UIColor colorWithRed:0.059 green:0.800 blue:0.620 alpha:1.0];
            break;
            
        case TestTypeJLPT3:
            color = [UIColor colorWithRed:0.075 green:0.831 blue:0.541 alpha:1.0];
            break;
            
        case TestTypeToefl:
            color = [UIColor colorWithRed:0.263 green:0.741 blue:0.819 alpha:1];
            break;
            
        case TestTypeToeic:
            color = [UIColor colorWithRed:0.067 green:0.682 blue:0.882 alpha:1.0];
            break;
            
        default:
            NSAssert(NO, @"没有正确的颜色可以选取");
            break;
    }
    
    return color;
}

+ (NSString *)partNameWithPartType:(PartTypeTags)partType {
    NSString *name = nil;
    switch (partType) {
        case PartType201:
        case PartType202:
        case PartType203:
            break;
        case PartType301:
        case PartType302:
        case PartType303:
            name = NSLocalizedString(@"パート 1", nil);
            break;
        case PartType304:
        case PartType305:
            name = NSLocalizedString(@"パート 2", nil);
            break;
        case PartType306:
            name = NSLocalizedString(@"問題1 課題理解", nil);
            break;
        case PartType307:
            name = NSLocalizedString(@"問題2 ポイント理解", nil);
            break;
        case PartType308:
            name = NSLocalizedString(@"問題3 概要理解", nil);
            break;
        case PartType309:
            if ([TestType isJLPTN3]) {
                name = NSLocalizedString(@"問題4 発話表現", nil);
            } else {
                name = NSLocalizedString(@"問題4 応答問題", nil);
            }
            break;
        case PartType310:
            if ([TestType isJLPTN3]) {
                name = NSLocalizedString(@"問題5 即時応答", nil);
            } else {
                name = NSLocalizedString(@"問題5 総合理解", nil);
            }
            break;
        case PartType401:
            name = NSLocalizedString(@"Part1", nil);
            break;
        case PartType402:
            name = NSLocalizedString(@"Part2", nil);
            break;
        case PartType403:
            name = NSLocalizedString(@"Part3", nil);
            break;
        case PartType404:
            name = NSLocalizedString(@"Part4", nil);
            break;
        case PartTypeMAX:
            name = NSLocalizedString(@"全部试题", nil);
            break;
            
        default:
            NSAssert(NO, @"没有正确的PartType");
            break;
    }
    
    return name;
}
@end
