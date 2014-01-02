//
//  settingsViewController.m
//  FBLoginFlow
//
//  Created by Tompkins, Nathan on 12/15/13.
//  Copyright (c) 2013 Tracy Liu. All rights reserved.
//

#import "settingsViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface settingsViewController () <FBLoginViewDelegate>

@end

@implementation settingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.tabBarItem initWithTitle:@"Settings" image:[UIImage imageNamed:@"tab_settings.png"] tag:2];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    FBLoginView* loginView = [[FBLoginView alloc]init];
    loginView.readPermissions = @[@"basic_info"];
    loginView.delegate = self;
    loginView.center = CGPointMake(160,330);
    [self.view addSubview:loginView];
    
    
    
    FBRequest* request = [FBRequest requestForMyFriends];
    
    request.parameters[@"fields"] =
    [NSString stringWithFormat:@"%@, installed",request.parameters[@"fields"]];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSMutableString* string = [[NSMutableString alloc] init];
        
        for(id<FBGraphUser> user in result[@"data"])
        {
            [string appendFormat:@"%@ installed the app? %@\n", [user first_name], user[@"installed"]?@"Yes":@"No"];
            // [[xvc friendUserNames] addObject:[user first_name]];
        }

    }];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    
    [FBLoginView class];
    NSSet* set = [NSSet setWithObjects:FBLoggingBehaviorFBRequests, nil];
    [FBSettings setLoggingBehavior:set];
    
    
}

    


@end
