//
//  DetailViewController.h
//  FeedReader
//
//  Created by JRamos on 2/11/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSString *url2;

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)email:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
