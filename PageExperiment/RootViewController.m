//
//  RootViewController.m
//  PageExperiment
//
//  Created by Adrien Long on 09/03/2016.
//  Copyright © 2016 Adrien Long. All rights reserved.
//

#import "RootViewController.h"
#import "ModelController.h"
#import "DataViewController.h"
#import <CoreLocation/CLLocationManager.h>

#import "RootView.h"

#import <TLYShyNavBar/TLYShyNavBarManager.h>

#import "AMScrollingNavBar-swift.h"

#import "TouchOverlayApplication.h"

#import "MyScrollView.h"

@interface RootViewController ()

@property (readonly, strong, nonatomic) ModelController *modelController;

@property (nonatomic, readonly) RootView *rootView;

@property(nonatomic, assign) CGFloat lastContentOffset;

@end

@implementation RootViewController

@synthesize modelController = _modelController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootView.controller = self;
    
    self.lastContentOffset = 0;
    
    if (self.pageViewController && [self.pageViewController.viewControllers.firstObject isKindOfClass:DataViewController.class]) {
        [self.headerScrollView setNeedsLayout];
        [self.headerScrollView layoutIfNeeded];
        DataViewController *dataController = self.pageViewController.viewControllers.firstObject;
        
        dataController.cstrStackViewTop.constant = CGRectGetMaxY(self.headerView.frame) + CGRectGetHeight(self.headerMapView.bounds);
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    DataViewController *dataController = self.pageViewController.viewControllers.firstObject;
    
    CGFloat dataHeight = dataController.scrollView.contentSize.height;
    
    self.cstrHeaderEmptyViewHeight.constant = dataHeight - dataController.cstrStackViewTop.constant;
}

- (ModelController *)modelController {
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[ModelController alloc] init];
    }
    return _modelController;
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    DataViewController *currentController = (DataViewController *)pageViewController.viewControllers.firstObject;
    
    DataViewController *newController = (DataViewController *)pendingViewControllers.firstObject;
    
    if (newController) {
        CGFloat dataOffset = CGRectGetMaxY(self.headerView.frame) + CGRectGetHeight(self.headerMapView.bounds);
        newController.scrollView.delegate = self;
        newController.cstrStackViewTop.constant = dataOffset ;
        [newController.view setNeedsLayout];
        [newController.view layoutIfNeeded];
        
        // Adjust newController scrollView
        newController.scrollView.contentOffset = CGPointMake(0, MIN(dataOffset - self.topLayoutGuide.length, currentController.scrollView.contentOffset.y));
    }
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        DataViewController *currentController = pageViewController.viewControllers.firstObject;
        
        self.cstrHeaderEmptyViewHeight.constant = currentController.scrollView.contentSize.height - currentController.cstrStackViewTop.constant;
//        [(ScrollingNavigationController *)self.navigationController followScrollView:currentController.scrollView delay:10.0f];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIScrollView *dataScrollView = ((DataViewController *)self.pageViewController.viewControllers.firstObject).scrollView;
    
//    CGFloat yOffset = MIN( scrollView.contentOffset.y , CGRectGetMinY(self.headerMapView.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame) );
    
    if (scrollView == dataScrollView) {
        
//        NSLog(@"DATA Content Offset %f", scrollView.contentOffset.y);
        
        self.headerScrollView.contentOffset = scrollView.contentOffset;
        
    }
    else if (scrollView == self.headerScrollView) {
        
//        NSLog(@"HEADER Content Offset %f", scrollView.contentOffset.y);
        
        dataScrollView.contentOffset = scrollView.contentOffset;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueEmbedPageViewController"]) {
        self.pageViewController = segue.destinationViewController;
        
        self.pageViewController.delegate = self;
        
        DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
        
        [self.pageViewController setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
        self.pageViewController.dataSource = self.modelController;
        
//        [(ScrollingNavigationController *)self.navigationController followScrollView:startingViewController.scrollView delay:10.0f];
    }
}

-(RootView *)rootView
{
    if (self.isViewLoaded) {
        if ([self.view isKindOfClass:RootView.class]) {
            return (RootView *)self.view;
        }
    }
    return nil;
}

- (IBAction)btnHeaderViewPushed:(id)sender {
    self.lblHeaderViewCenter.text = [[NSDate date] description];
}

@end
