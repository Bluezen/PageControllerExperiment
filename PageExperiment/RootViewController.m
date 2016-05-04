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
    
//    self.headerScrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    if (self.pageViewController && [self.pageViewController.viewControllers.firstObject isKindOfClass:DataViewController.class]) {
        [self.headerScrollView setNeedsLayout];
        [self.headerScrollView layoutIfNeeded];
        DataViewController *dataController = self.pageViewController.viewControllers.firstObject;
        
        dataController.cstrStackViewTop.constant = CGRectGetMaxY(self.headerMapView.frame);
        
//        self.headerScrollView.contentOffset = CGPointMake(0, -64);
        
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    TouchOverlayApplication *app = (TouchOverlayApplication *)[UIApplication sharedApplication];
//    app.shouldForward = YES;
//    app.viewToForward = self.headerScrollViewContainerView;
//}
//
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    
//    TouchOverlayApplication *app = (TouchOverlayApplication *)[UIApplication sharedApplication];
//    app.shouldForward = NO;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        newController.scrollView.delegate = self;
        newController.cstrStackViewTop.constant = CGRectGetMaxY(self.headerMapView.frame) ;
        [newController.view setNeedsLayout];
        [newController.view layoutIfNeeded];
        
        // Adjust newController scrollView
        newController.scrollView.contentOffset = CGPointMake(0, MIN(CGRectGetMaxY(self.headerMapView.frame) - 64, currentController.scrollView.contentOffset.y));
    }
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
//        DataViewController *currentController = pageViewController.viewControllers.firstObject;
//        
//        [(ScrollingNavigationController *)self.navigationController followScrollView:currentController.scrollView delay:10.0f];
    }
}

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    CGFloat mapOffset = CGRectGetMinY(self.headerMapView.frame);
//    
//    if (scrollView == self.headerScrollView && targetContentOffset->y > mapOffset) {
//        scrollView.delegate = nil;
//        
//        DataViewController *currentController = self.pageViewController.viewControllers.firstObject;
//        currentController.scrollView.delegate = self;
//        
//    }
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.isViewLoaded) {
        return;
    }
    
    DataViewController *currentController = self.pageViewController.viewControllers.firstObject;
    
    CGFloat mapOffset = CGRectGetMinY(self.headerMapView.frame);
    
    if (scrollView == currentController.scrollView) {
        
        NSLog(@"Content Offset %f", scrollView.contentOffset.y);
        
        
        CGFloat yOffset = MIN( scrollView.contentOffset.y , mapOffset - CGRectGetMaxY(self.navigationController.navigationBar.frame));
        
        self.headerScrollView.contentOffset = CGPointMake(0, yOffset);
        
    }
//    else if (scrollView == self.headerScrollView) {
//        
//        if (scrollView.contentOffset.y < (mapOffset - CGRectGetMaxY(self.navigationController.navigationBar.frame)))
//        {
//            currentController.scrollView.contentOffset = scrollView.contentOffset;
//        } else {
//            CGFloat yOffset = mapOffset - CGRectGetMaxY(self.navigationController.navigationBar.frame);
//            scrollView.contentOffset = CGPointMake(0, yOffset);
//        }
//    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueEmbedPageViewController"]) {
        self.pageViewController = segue.destinationViewController;
        
        self.pageViewController.delegate = self;
        
        DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
        
        [self.pageViewController setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
        self.pageViewController.dataSource = self.modelController;
        
//        startingViewController.scrollView.delegate = self;
        
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
