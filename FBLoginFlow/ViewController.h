//
//  ViewController.h
//  FBLoginFlow
//
//  Created by Tracy Liu on 10/20/13.
//  Copyright (c) 2013 Tracy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *uiLabel;

@property (weak, nonatomic) IBOutlet UITextView *uiTextView;


- (IBAction)clickBasicShare:(id)sender;
- (IBAction)clickFriends:(id)sender;


@end
