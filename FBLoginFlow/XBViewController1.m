//
//  XBViewController.m
//  FBLoginFlow
//
//  Created by Tompkins, Nathan on 12/22/13.
//  Copyright (c) 2013 Tracy Liu. All rights reserved.
//

#import "XBViewController1.h"
#import "FriendProtocols.h"
#import "XBSelectedRow.h"

@interface XBViewController1 () <UITableViewDelegate>

@end

@implementation XBViewController1




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

            // Custom initialization
            UITabBarItem *tbi = [self tabBarItem];
            [tbi setImage:[UIImage imageNamed:@"tab_xbox.png"]];
            [tbi setTitle:@"Xbox Live"];
        _curFriendInfo = [[NSMutableArray alloc] init];
        _sortedFriendInfo = [[NSMutableArray alloc] init];
        _finalSortedFriendInfo = [[NSArray alloc] init];


    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    FBRequest* request = [FBRequest requestForMyFriends];
    
    request.parameters[@"fields"] =
    [NSString stringWithFormat:@"%@, installed",request.parameters[@"fields"]];

  
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
       for(id<FBGraphUser> user in result[@"data"])
        {
        if ([user.last_name characterAtIndex:0] >= (int)'M') {
        
        NSString *curName = [[NSString alloc] initWithFormat:@"%@, %@, %@", user.last_name, user.name, user.id];


        [_sortedFriendInfo addObject:curName]; }
            


            
        }
        
        //_sortedFriendInfo  = [self alphaSort:_curFriendInfo];

        _sortedArray = [[NSArray alloc] initWithArray:[_sortedFriendInfo sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
           //NSLog(@"%@", _sortedArray);
       // _finalSortedFriendInfo = [self nameSwap:_sortedArray];
        
        
        
        
        for(id username in _sortedFriendInfo) {

        }
    }];

    [self setSortOrdering:FBFriendSortByLastName];
    
    self.cancelButton  = nil;
    self.doneButton  = nil;
    self.delegate = self;
    self.tableView.delegate = self;

    
    //self.fieldsForRequest = [NSSet setWithObjects:@"devices", nil];
    [self setSortOrdering:FBFriendSortByLastName];

    [self loadData];

    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"XboxLIVE_RGBvectorKO_horizontal_2013.png"]];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xbox_bg.png"]];
    [titleView setFrame:CGRectMake(64, -12, 192, 72)];
    [bgView setFrame:CGRectMake(0, 0, 320, 50)];
    
    [self.view addSubview:bgView];
    [self.view addSubview:titleView];
 
 
    
    [self.tableView setFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)friendPickerViewController:(FBFriendPickerViewController *)friendPicker shouldIncludeUser:(id<FBGraphUserExtraFields>)user
{

    // Loop through list of devices for the friend
    
    if ([user.last_name characterAtIndex:0] >= (int)'M') {
    


            return YES;
        }
    
    // Friend is not an iOS user, do not include them
    return NO;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XBSelectedRow *xbr = [[XBSelectedRow alloc] init];
    [[self navigationController] pushViewController:xbr animated:YES];
    self.navigationController.navigationBar.hidden = 0;
    int rowTotal = 0;
    for (int i=0; i < indexPath.section; i++) {
        rowTotal += [tableView numberOfRowsInSection:i];
    }
        
    NSString *selectedName = [[NSString alloc] initWithString:_sortedArray[indexPath.row+rowTotal ]];
    [xbr setMyName:[self nameSwap:selectedName]];
    [xbr setMyID:@"placeholder text"];
    NSArray *splitName = [selectedName componentsSeparatedByString:@","];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=100&height=100", [splitName[2] stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    NSLog(@"%@", splitName[2]);
    [xbr setMyProfileImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
}

/*

- (NSArray *)alphaSort:(NSArray *)array {
    
    __block NSString *lastWord = nil;
    __block NSString *firstWord = nil;
    __block NSString *reverseName = nil;
    NSMutableArray *reverseArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
    [array[i] enumerateSubstringsInRange:NSMakeRange(0, [array[i] length]) options:NSStringEnumerationByWords | NSStringEnumerationReverse usingBlock:^(NSString *substring, NSRange subrange, NSRange enclosingRange, BOOL *stop) {
        lastWord = substring;
        
        firstWord = [array[i] stringByReplacingOccurrencesOfString:lastWord withString:@""];
        reverseName = [NSString stringWithFormat:@"%@ %@", lastWord, firstWord];
        
        *stop = YES;
        [reverseArray addObject:reverseName];
        
    }];

    }

    return reverseArray;
}*/

- (NSString *)nameSwap:(NSString *)array {
    NSArray *lastWord = nil;
    //__block NSString *firstWord = nil;
   // NSMutableArray *reverseArray = [[NSMutableArray alloc] init];
    
    //for (int i = 0; i < [array count]; i++) {
        lastWord = [array componentsSeparatedByString:@","];
        
        NSString *reverseName  = [[NSString alloc] initWithFormat:@"%@", lastWord[1]];

        
        
        
        
        /*[array[i] enumerateSubstringsInRange:NSMakeRange(0, [array[i] length]) options:NSStringEnumerationByWords usingBlock:^(NSString *substring, NSRange subrange, NSRange enclosingRange, BOOL *stop) {
            firstWord = substring;
            
            lastWord = [array[i] stringByReplacingOccurrencesOfString:firstWord withString:@""];
            reverseName = [NSString stringWithFormat:@"%@%@", lastWord, firstWord];
            
            *stop = YES;
            [reverseArray addObject:reverseName];
            
        }];*/
        
   // }
    
    return reverseName;
    
    
}


@end
