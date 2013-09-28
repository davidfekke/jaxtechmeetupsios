//
//  DetailViewController.h
//  JaxTechMeetups
//
//  Created by David P Fekke on 9/28/13.
//  Copyright (c) 2013 David Fekke L.L.C. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
