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

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    DataViewController *dataController = (DataViewController *)self.controller.pageViewController.viewControllers.firstObject;
    
    dataController.scrollView.delegate = nil;
    self.controller.headerScrollView.delegate = nil;
    
    UIStackView *stackView = dataController.stackView;
    
    CGPoint stackPoint = [stackView convertPoint:point fromView:self];
    
    //
    // Check if the point to test is NOT inside the data controller visible views
    if (![stackView pointInside:stackPoint withEvent:event])
    {
        //
        // Then if it occured on top of the Map, just forward it to the Map
        CGPoint mapPoint = [self.controller.headerMapView convertPoint:point fromView:self];
        
        if ([self.controller.headerMapView pointInside:mapPoint withEvent:event]) {
            
            if (dataController.scrollView.isDecelerating) {
                // Must explicitely call animated:NO to cancel all animations
                [dataController.scrollView setContentOffset:dataController.scrollView.contentOffset animated:NO];
            }
            
            return [self.controller.headerMapView hitTest:mapPoint withEvent:event];
        }
        
        //
        // Else
        CGPoint headerPoint = [self.controller.headerScrollView convertPoint:point fromView:self];
        
        if ([self.controller.headerScrollView pointInside:headerPoint withEvent:event]) {
            
            self.controller.headerScrollView.delegate = self.controller;
            
            if (dataController.scrollView.isDecelerating) {
                // Must explicitely call animated:NO to cancel all animations
                [dataController.scrollView setContentOffset:dataController.scrollView.contentOffset animated:NO];
            }
            
            return [self.controller.headerScrollView hitTest:headerPoint withEvent:event];
        }
        
    }
    
    if (self.controller.headerScrollView.isDecelerating) {
        // Must explicitely call animated:NO to cancel all animations
        [self.controller.headerScrollView setContentOffset:self.controller.headerScrollView.contentOffset animated:NO];
    }
    
    dataController.scrollView.delegate = self.controller;
    
    return [super hitTest:point withEvent:event];
}

@end
