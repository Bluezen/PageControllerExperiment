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

#import <TLYShyNavBar/TLYShyNavBarManager.h>

#import "AMScrollingNavBar-swift.h"

@interface RootViewController ()

@property (readonly, strong, nonatomic) ModelController *modelController;
@end

@implementation RootViewController

@synthesize modelController = _modelController;

- (void)viewDidLoad {
    [super viewDidLoad];
}

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
        newController.cstrStackViewTop.constant = 200.0f + 64;
        [newController.view setNeedsLayout];
        [newController.view layoutIfNeeded];
        
        // Adjust newController scrollView
        newController.scrollView.contentOffset = CGPointMake(0, MIN(200.0f + 44.0f, currentController.scrollView.contentOffset.y));
    }
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
//        DataViewController *previousController = previousViewControllers.firstObject;
        DataViewController *currentController = pageViewController.viewControllers.firstObject;
        
        [(ScrollingNavigationController *)self.navigationController followScrollView:currentController.scrollView delay:10.0f];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    DataViewController *currentController = self.pageViewController.viewControllers.firstObject;
    
    if (scrollView == currentController.scrollView) {
        
        NSLog(@"Content Offset %f", scrollView.contentOffset.y);
        
        self.cstrHeaderViewTop.constant = MAX(64.0f -scrollView.contentOffset.y , -200);
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
        
        startingViewController.scrollView.delegate = self;
        
        [(ScrollingNavigationController *)self.navigationController followScrollView:startingViewController.scrollView delay:10.0f];
        
        startingViewController.cstrStackViewTop.constant = 200 + 64;
    }
}

@end
