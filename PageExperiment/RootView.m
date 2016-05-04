//
//  RootView.m
//  PageExperiment
//
//  Created by Adrien Long on 04/05/2016.
//  Copyright © 2016 Adrien Long. All rights reserved.
//

#import "RootView.h"

#import "DataViewController.h"

@implementation RootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    DataViewController *dataController = (DataViewController *)self.controller.pageViewController.viewControllers.firstObject;
    
    
    UIStackView *stackView = dataController.stackView;
    
    CGPoint stackPoint = [stackView convertPoint:point fromView:self];
    
    if (![stackView pointInside:stackPoint withEvent:event])
    {
        CGPoint mapPoint = [self.controller.headerMapView convertPoint:point fromView:self];
        
        if ([self.controller.headerMapView pointInside:mapPoint withEvent:event]) {
            
            if (dataController.scrollView.isDecelerating) {
                [dataController.scrollView setContentOffset:dataController.scrollView.contentOffset];
            }
            
            return [self.controller.headerMapView hitTest:mapPoint withEvent:event];
        }
        
//        CGPoint headerPoint = [self.controller.headerScrollViewContainerView convertPoint:point fromView:self];
//        
//        if ([self.controller.headerScrollViewContainerView pointInside:headerPoint withEvent:event]) {
//            
//            if (dataController.scrollView.isDecelerating) {
//                [dataController.scrollView setContentOffset:dataController.scrollView.contentOffset];
//            }
//            
//            dataController.scrollView.delegate = nil;
//            self.controller.headerScrollView.delegate = self.controller;
//            return [self.controller.headerScrollViewContainerView hitTest:point withEvent:event];
//        }
        
    }
    
    if (self.controller.headerScrollView.isDecelerating) {
        [self.controller.headerScrollView setContentOffset:self.controller.headerScrollView.contentOffset];
    }
    
    self.controller.headerScrollView.delegate = nil;
    dataController.scrollView.delegate = self.controller;
    return [super hitTest:point withEvent:event];
}

@end
