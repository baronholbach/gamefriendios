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
#import "XBViewController1.h"
#import "PSViewController.h"
#import "settingsViewController.h"


@interface ViewController () <FBLoginViewDelegate, UITextFieldDelegate>

@end

@implementation ViewController

int i = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    
    
    FBLoginView* loginView = [[FBLoginView alloc]init];
    loginView.readPermissions = @[@"basic_info"];
    loginView.delegate = self;
    loginView.center = CGPointMake(160,330);

    self.networkOptions  = [[NSArray alloc] initWithObjects:@"Xbox Live",@"PlayStation Network",@"Both", nil];
    }
    

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    
    [FBLoginView class];
    NSSet* set = [NSSet setWithObjects:FBLoggingBehaviorFBRequests, nil];
    [FBSettings setLoggingBehavior:set];
    loginView.hidden = 1;


   
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    [self.view addSubview:loginView];
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    
   // self.uiLabel.text = [NSString stringWithFormat:@"Hi, %@", [user first_name]];
    
    //NSString *greetingText = @"Greetings";
    //self.uiLabel.text = [NSString stringWithFormat:@"Hi, %@ %@ ", greetingText, [user first_name]];
   
    
    
    self.networkPicker.hidden = 0;
    
    loginView.center = CGPointMake(150,450);
    
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


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.networkOptions objectAtIndex:row];
}
    
    
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (row) {
        case 0:
        {

            UILabel *xbLabel = [[UILabel alloc] init];

            xbLabel.frame = CGRectMake(505, -15, 280, 40);
            [xbLabel setFont:[UIFont fontWithName:@"Futura" size:17.0]];
            xbLabel.text = @"What is your Xbox Live Gamertag?";
            self.uiLabel.hidden = 1;
                       [self.networkPicker addSubview:xbLabel];
            
            [UIView animateWithDuration:0.5 animations:^{
            self.networkPicker.frame = CGRectOffset(self.networkPicker.frame, -480, 0);
                _xbEntry.frame = CGRectOffset(_xbEntry.frame, -485, 0);
            }];

            
        
            NSLog(@"%d",self.networkPicker.userInteractionEnabled);



            
            break;
        }
        case 1:
            //load PSN page
            break;
            
        case 2:
    {
                        break;
    }
            
    }
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
        _confirmButton.hidden = NO;
        _networkPicker.hidden = YES;
        [textField resignFirstResponder];


        return YES;
}

-(IBAction)confirmPressed:(id)sender  {
    XBViewController1 *xvc =[[XBViewController1 alloc] init];
    PSViewController *pvc = [[PSViewController alloc]  init];
    settingsViewController *svc =[[settingsViewController alloc] init];

    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:pvc, xvc, svc, nil];
    [tbc setViewControllers:viewControllers animated:NO];
    [self presentViewController:tbc animated:YES completion:NULL];

}

@end
