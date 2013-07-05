//
//  ZZTextView.m
//  ProjectListening
//
//  Created by zhaozilong on 13-4-25.
//
//

#import "ZZTextView.h"
#import "NSString+ZZString.h"

@implementation ZZTextView

- (void)awakeFromNib {
    [self setEditable:NO];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setScrollEnabled:NO];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(myDefine:)) {
        return YES;
    } else if (action == @selector(copy:)) {
        return YES;
    } else if (action == @selector(sysDefine:)) {
        return YES;
    }
    
    return NO;
}

- (void)myDefine:(id)sender {
    
    [_parentVC catchAWordToShow:[NSString getSelectedWordInRange:[self selectedRange] withText:[self text]]];
    
}

- (void)sysDefine:(id)sender {
    UIReferenceLibraryViewController *dict = [[UIReferenceLibraryViewController alloc] initWithTerm:[NSString getSelectedWordInRange:[self selectedRange] withText:[self text]]];

    [_parentVC.navigationController presentModalViewController:dict animated:YES];
    [dict release];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
