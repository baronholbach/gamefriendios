//
//  ViewController.h
//  FBLoginFlow
//
//  Created by Tracy Liu on 10/20/13.
//  Copyright (c) 2013 Tracy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *uiLabel;

@property (weak, nonatomic) IBOutlet UITextView *uiTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *networkPicker;
@property (weak, nonatomic) IBOutlet UITextField *xbEntry;
@property (strong, nonatomic) NSArray *networkOptions;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

- (IBAction)clickBasicShare:(id)sender;
- (IBAction)clickFriends:(id)sender;
- (IBAction)confirmPressed:(id)sender;



@end
