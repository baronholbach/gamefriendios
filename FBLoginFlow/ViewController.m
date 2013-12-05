//
//  ViewController.m
//  FBLoginFlow
//
//  Created by Tracy Liu on 10/20/13.
//  Copyright (c) 2013 Tracy Liu. All rights reserved.
//

#import "ViewController.h"
#import "FriendProtocols.h"
#import <FacebookSDK/FacebookSDK.h>


@interface ViewController () <FBLoginViewDelegate, FBFriendPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    FBLoginView* loginView = [[FBLoginView alloc]init];
    loginView.readPermissions = @[@"basic_info",@"email", @"user_likes"];
    loginView.delegate = self;
    loginView.frame = CGRectOffset(loginView.frame, 20, 50);
    loginView.center = self.view.center;
    self.uiLabel.text=@"Test";
    [self.view addSubview:loginView];
    
}

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    FBRequest* request = [FBRequest requestForMyFriends];
    
    request.parameters[@"fields"] =
        [NSString stringWithFormat:@"%@, installed",request.parameters[@"fields"]];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSMutableString* string = [[NSMutableString alloc] init];
        
        for(id<FBGraphUser> user in result[@"data"])
        {
            [string appendFormat:@"%@ installed the app? %@\n", [user first_name], user[@"installed"]?@"Yes":@"No"];
        }
        
         self.uiTextView.text = string;
    }];
    
   
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.uiLabel.text=@"Hi, please login to get started.";
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    
   // self.uiLabel.text = [NSString stringWithFormat:@"Hi, %@", [user first_name]];
    
    NSString *greetingText = @"Greetings";
    
       self.uiLabel.text = [NSString stringWithFormat:@"Hi, %@ %@ ", greetingText, [user first_name]];
    
    
}

-(BOOL)friendPickerViewController:(FBFriendPickerViewController *)friendPicker shouldIncludeUser:(id<FBGraphUserExtraFields>)user
{
    NSArray *deviceData = user.devices;
    
    for(NSDictionary *deviceObject in deviceData)
    {
        if ([@"iOS" isEqualToString:deviceObject[@"os"]])
        {
            return YES;
        }
    }
    
    return NO;
}

- (void)facebookViewControllerCancelWasPressed:(id)sender
{
    NSLog(@"Friend selection cancelled.");
    [self dismissModalViewControllerAnimated:YES];
}

- (void)facebookViewControllerDoneWasPressed:(id)sender
{
    FBFriendPickerViewController *fpc = (FBFriendPickerViewController *)sender;
    
    for(id<FBGraphUser> user in fpc.selection)
    {
        NSLog(@"Friend selected: %@", user.name);
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickBasicShare:(id)sender {
    
    [FBNativeDialogs presentShareDialogModallyFrom:self initialText:@"FB Log Flow" image:nil url:nil handler:^(FBNativeDialogResult result, NSError *error) {
        if (error)
            NSLog(@"Error!");
            }];
}

- (IBAction)clickFriends:(id)sender {
    
    FBFriendPickerViewController* vc = [[FBFriendPickerViewController alloc]init];
    
    vc.title = @"Your facebook friends";
    
    vc.delegate = self;
    
    vc.fieldsForRequest = [NSSet setWithObjects:@"devices", nil];
    
    [vc loadData];
    [vc presentModallyFromViewController:self animated:YES handler:^(FBViewController *sender, BOOL donePressed) {
        if(donePressed)
        {
            NSLog(@"Success!");
        }
    }];
}


@end
