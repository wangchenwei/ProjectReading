//
//  TitleCell.m
//  ProjectListening
//
//  Created by zhaozilong on 13-4-15.
//
//

#import "TitleCell.h"

@implementation TitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLabelInfoTitleName:(NSString *)titleName quesNum:(int)quesNum rightNum:(int)rightNum soundTime:(NSString *)soundTime {
    
    NSString *info = [NSString stringWithFormat:@"%@", titleName];
    [_titleInfoLabel setText:info];
    
    NSString *detail = nil;
//    if (rightNum == 0) {
//        //本地化一下子
//        detail = [NSString stringWithFormat:@"%d道问题-时长:%@", quesNum, soundTime];
//    } else {
//        detail = [NSString stringWithFormat:@"%d道问题-答对%d题-时长:%@", quesNum, rightNum, soundTime];
//    }
    detail = [NSString stringWithFormat:@"正确比例:%d/%d题-时长:%@", rightNum, quesNum, soundTime];
    [_detailLabel setText:detail];
}

- (void)dealloc {
    [_titleInfoLabel release];
    [_detailLabel release];
    [super dealloc];
}
@end
