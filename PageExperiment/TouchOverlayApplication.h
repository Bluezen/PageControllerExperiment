//
//  TouchOverlayApplication.h
//  PageExperiment
//
//  Created by Adrien Long on 04/05/2016.
//  Copyright © 2016 Adrien Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchOverlayApplication : UIApplication

@property(nonatomic, weak) UIView *viewToForward;

@property(nonatomic, assign) BOOL shouldForward;

@end
