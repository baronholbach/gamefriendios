//
//  XBViewController.h
//  FBLoginFlow
//
//  Created by Tompkins, Nathan on 12/22/13.
//  Copyright (c) 2013 Tracy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface XBViewController1 : FBFriendPickerViewController <FBFriendPickerDelegate>
@property NSMutableArray *curFriendInfo;
@property NSMutableArray *sortedFriendInfo;
@property NSArray *finalSortedFriendInfo;
@property NSArray *sortedArray;

//- (NSArray *) alphaSort:(NSArray *)array;
- (NSString *) nameSwap:(NSString *)array;

@end
