//
//  DetailViewController.m
//  FeedReader
//
//  Created by JRamos on 2/11/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
        // Update the view.
        [self configureView];
    
        [self.masterPopoverController dismissPopoverAnimated:YES];
           
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.url2) {
        NSLog(@"%@", self.url2);
        self.searchBar.text = self.url2;
        NSURL *url = [NSURL URLWithString:(self.url2)];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webview loadRequest:requestObj];
    }
    else {
        self.searchBar.text = @"http://sciencenews.org";
        NSLog(@"%@", @"this loaded");
        NSURL *url = [NSURL URLWithString:@"http://sciencenews.org"];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webview loadRequest:requestObj];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Stories", @"Stories");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)email:(UIBarButtonItem *)sender {
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]){
        //**********************************************************************
        //not really sure how to fix this. Mail won't dismiss without this line 
        composer.mailComposeDelegate = self;
        //**********************************************************************
        [composer setSubject:@"Check This Story Out!"];
        [composer setMessageBody:self.url2 isHTML:NO];
        [composer setModalTransitionStyle:(UIModalTransitionStyleCoverVertical)];
        [self presentViewController:composer animated:YES completion:Nil];
        
        
    }
    else{
    }
    
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (error){
        NSString *errorTitle = @"Mail Error";
        NSString *errorDescription = [error localizedDescription];
        UIAlertView *errorView = [[UIAlertView alloc]initWithTitle:errorTitle message:errorDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [errorView show];
    }
    [controller dismissViewControllerAnimated:YES completion:Nil];
    
}

@end
