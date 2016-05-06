//
//  RootViewController.h
//  PageExperiment
//
//  Created by Adrien Long on 09/03/2016.
//  Copyright © 2016 Adrien Long. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (weak, nonatomic) IBOutlet UIScrollView *headerScrollView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet MKMapView *headerMapView;
@property (weak, nonatomic) IBOutlet UIView *headerScrollViewContainerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cstrHeaderEmptyViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cstrHeaderViewTop;

@property (weak, nonatomic) IBOutlet UIView *containerView;

- (IBAction)btnHeaderViewPushed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderViewCenter;

@end

