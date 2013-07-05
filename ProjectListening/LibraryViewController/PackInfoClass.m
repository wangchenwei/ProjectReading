//
//  PackInfoClass.m
//  ProjectListening
//
//  Created by zhaozilong on 13-4-15.
//
//

#import "PackInfoClass.h"
#import "UserInfo.h"

@implementation PackInfoClass

- (void)dealloc {
    
    [_titleNumArray release];
    
    [super dealloc];
}

+ (PackInfoClass *)packInfoWithPackName:(NSString *)name isVip:(BOOL)isVip isDownload:(BOOL)isDownload progress:(CGFloat)progress isFree:(BOOL)isFree {
    
    return [[[self alloc] initWithPackName:name isVip:isVip isDownload:isDownload progress:progress isFree:isFree] autorelease];
}

- (id)initWithPackName:(NSString *)name isVip:(BOOL)isVip isDownload:(BOOL)isDownload progress:(CGFloat)progress isFree:(BOOL)isFree {
    
    self = [super init];
    if (self) {
        self.packName = name;
        self.isVip = isVip;
        self.isDownload = isDownload;
        self.isFree = isFree;
        self.progress = progress;
        
        //检测是否为iyuba的vip会员
//        if ([UserInfo isVIPValid]) {
//            if (_isFree) {
//                self.PICStatus = PICStatusFree;
//            } else if (/*!_isVip || */!_isDownload) {
//                self.PICStatus = PICStatusDownload;
//            } else {
//                self.PICStatus = PICStatusFree;
//            }
//        } else {
//            if (_isFree) {//当前是否是免费的题目
//                self.PICStatus = PICStatusFree;
//            } else if (!_isVip){
//                self.PICStatus = PICStatusPurchase;
//            } else if (!_isDownload) {
//                self.PICStatus = PICStatusDownload;
//            } else {
//                self.PICStatus = PICStatusFree;
//            }
//        }
        
        if (_isVip || [UserInfo isVIPValid]) {
            if (_isFree || _isDownload) {
                self.PICStatus = PICStatusFree;
            } else {
                self.PICStatus = PICStatusDownload;
            }
        } else {
            self.PICStatus = PICStatusPurchase;
        }

        
        _titleNumArray = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

- (void)setIyubaVipWithIsDownload:(BOOL)isDownload isFree:(BOOL)isFree isVip:(BOOL)isVip progress:(float)progress {
    
//    self.progress = progress;
    
    if (isVip == NO) {
        if ([UserInfo isVIPValid]) {
            if (isFree || isDownload) {
                self.PICStatus = PICStatusFree;
            } else if (self.PICStatus == PICStatusPurchase) {
                self.PICStatus = PICStatusDownload;
            }
        } else {
            self.PICStatus = PICStatusPurchase;
        }
    } else {
        if (isFree || isDownload/* || self.PICStatus == PICStatusFree*/) {
            self.PICStatus = PICStatusFree;
        } else if (self.PICStatus != PICStatusDownloading && self.PICStatus != PICStatusWaiting) {
            self.PICStatus = PICStatusDownload;
        }
    }
}

- (void)isDelete {
//    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:<#(NSString *)#> error:<#(NSError **)#>]
//    [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:nil];
}

@end
