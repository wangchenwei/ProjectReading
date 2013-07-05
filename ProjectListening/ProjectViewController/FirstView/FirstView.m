//
//  FirstView.m
//  ProjectListening
//
//  Created by zhaozilong on 13-4-20.
//
//

#import "FirstView.h"
#import "RootViewController.h"
#import "UserSetting.h"

@implementation FirstView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)awakeFromNib {
//    [_assKenBtn setSelected:YES];
//    [_assKenBtn setEnabled:NO];
    
//    [_timeOneBtn setSelected:YES];
//    [_timeOneBtn setEnabled:NO];
    
//    [UserSetting setStudyTime:1800];
//    [UserSetting setAssistantID:0];
    
    //设置助理信息
    NSString *path = [ZZAcquirePath getPlistAssistantFromBundle];
    NSMutableArray *assArray = [NSMutableArray arrayWithContentsOfFile:path];
    int count = [assArray count];
    for (int i = 0; i < count; i++) {
        NSMutableDictionary *dic = [assArray objectAtIndex:i];
        //此处本地化一下子
        NSString *info = [dic objectForKey:@"kAssCInfo"];
        int assID = [[dic objectForKey:@"kAssID"] integerValue];
        
        switch (assID) {
            case 0:
                [_dayeLabel setText:info];
                break;
                
            case 1:
                [_xiaotaoLabel setText:info];
                break;
                
            default:
                break;
        }
    }
    
    //设置难度信息
    path = [ZZAcquirePath getPlistStudyTimeFromBundle];
    NSMutableArray *timeArray = [NSMutableArray arrayWithContentsOfFile:path];
    count = [timeArray count];
    for (int i = 0; i < count; i++) {
        NSMutableDictionary *dic = [timeArray objectAtIndex:i];
        //此处本地化一下子
        NSString *info = [dic objectForKey:@"kStudyTimeInfoCN"];
        int studyTime = [[dic objectForKey:@"kStudyTime"] integerValue];
        
        switch (studyTime) {
            case 1800:
                [_easyLabel setText:info];
                break;
                
            case 3600:
                [_normalLabel setText:info];
                break;
                
            case 7200:
                [_hardLabel setText:info];
                break;
                
            default:
                break;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_assKenBtn release];
    [_assKateBtn release];
    [_timeOneBtn release];
    [_timeTwoBtn release];
    [_timeThreeBtn release];
    [_startBtn release];
    [_ENHView release];
    [_easyLabel release];
    [_normalLabel release];
    [_hardLabel release];
    [_xiaotaoLabel release];
    [_dayeLabel release];
    [super dealloc];
}
- (IBAction)KenBtnPressed:(id)sender {
//    [_assKenBtn setSelected:YES];
//    [_assKateBtn setSelected:NO];
    
    [_assKenBtn setEnabled:NO];
    [_assKateBtn setEnabled:YES];
    
    [UserSetting setAssistantID:0];
    [UserSetting removeAssistantTextureExcept:0];
    
    [self startBtnPressed:nil];
}

- (IBAction)KateBtnPressed:(id)sender {
//    [_assKenBtn setSelected:NO];
//    [_assKateBtn setSelected:YES];
    
    [_assKenBtn setEnabled:YES];
    [_assKateBtn setEnabled:NO];
    
    [UserSetting setAssistantID:1];
    [UserSetting removeAssistantTextureExcept:1];
    
    [self startBtnPressed:nil];
}

- (IBAction)timeOneBtnPressed:(id)sender {
//    [_timeOneBtn setSelected:YES];
//    [_timeTwoBtn setSelected:NO];
//    [_timeThreeBtn setSelected:NO];
    
    [_timeOneBtn setEnabled:NO];
    [_timeTwoBtn setEnabled:YES];
    [_timeThreeBtn setEnabled:YES];
    
    [UserSetting setStudyTime:1800];
    
    [self nextPage];
}

- (IBAction)timeTwoBtnPressed:(id)sender {
//    [_timeOneBtn setSelected:NO];
//    [_timeTwoBtn setSelected:YES];
//    [_timeThreeBtn setSelected:NO];
    
    [_timeOneBtn setEnabled:YES];
    [_timeTwoBtn setEnabled:NO];
    [_timeThreeBtn setEnabled:YES];
    
    [UserSetting setStudyTime:3600];
    
    [self nextPage];
}

- (IBAction)timeThreeBtnPressed:(id)sender {
//    [_timeOneBtn setSelected:NO];
//    [_timeTwoBtn setSelected:NO];
//    [_timeThreeBtn setSelected:YES];
    
    [_timeOneBtn setEnabled:YES];
    [_timeTwoBtn setEnabled:YES];
    [_timeThreeBtn setEnabled:NO];
    
    [UserSetting setStudyTime:7200];
    
    [self nextPage];
}

- (void)nextPage {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:YES];
    [_ENHView removeFromSuperview];
//    [UIView setAnimationDelegate:self];
    // 动画完毕后调用某个方法
    //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    [UIView commitAnimations];
}

- (IBAction)startBtnPressed:(id)sender {
    [[RootViewController sharedRootViewController] startOfEverythingNew];
}
@end
