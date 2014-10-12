//
//  DetailViewController.m
//  JaxTechMeetups
//
//  Created by David P Fekke on 9/28/13.
//  Copyright (c) 2013 David Fekke L.L.C. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        
        NSDate *date = [[NSDate alloc] init];
        
        NSString *epochTime = [self.detailItem valueForKey:@"time"];
        
        // Convert NSString to NSTimeInterval
        NSTimeInterval seconds = ([epochTime doubleValue] / 1000); //- 14400000;
        
        date = [NSDate dateWithTimeIntervalSince1970:seconds];
        NSString *myDate = [self getLocalDateFromUTC:date forFormat:nil];
        self.groupName.text = [[self.detailItem valueForKey:@"group"] valueForKey:@"name"];
        self.eventTitle.text = [self.detailItem valueForKey:@"name"];
        self.eventTime.text = myDate;//[date description];
        [self.eventDescription loadHTMLString:[NSString stringWithFormat:@"<span style=\"font-family: %@; font-size: %i\">%@</span>",
                                               @"helvetica",
                                               12,
                                               [self.detailItem valueForKey:@"description"]] baseURL:nil];
        ;
        [self.eventDescription stringByEvaluatingJavaScriptFromString:@"document.body.style.fontFamily = 'Verdana'"];
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
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

-(NSString*)getLocalDateFromUTC:(NSDate *)utcDate forFormat:(NSString*)returnFormat
{
    if (!returnFormat) {
        returnFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:returnFormat];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //NSLog(@"utcDate: %@", utcDate);
    //NSDate *notificationDate = [dateFormatter dateFromString:utcDate];
    
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"MM/dd/yyyy '@' h:mm a "];
    NSString *localDate = [dateFormatter stringFromDate:utcDate];
    
    return localDate;
}

@end
