//
//  TouchOverlayApplication.m
//  PageExperiment
//
//  Created by Adrien Long on 04/05/2016.
//  Copyright © 2016 Adrien Long. All rights reserved.
//

#import "TouchOverlayApplication.h"

@implementation TouchOverlayApplication

- (void) sendEvent:(UIEvent *)event
{
    // Collect touches
    NSSet *touches = [event allTouches];
    NSMutableSet *began = nil;
    NSMutableSet *moved = nil;
    NSMutableSet *ended = nil;
    NSMutableSet *cancelled = nil;
    
    // Sort the touches by phase for event dispatch
    for(UITouch *touch in touches) {
        switch ([touch phase]) {
            case UITouchPhaseBegan:
                if (!began) began = [NSMutableSet set];
                [began addObject:touch];
                break;
            case UITouchPhaseMoved:
                if (!moved) moved = [NSMutableSet set];
                [moved addObject:touch];
                break;
            case UITouchPhaseEnded:
                if (!ended) ended = [NSMutableSet set];
                [ended addObject:touch];
                break;
            case UITouchPhaseCancelled:
                if (!cancelled) cancelled = [NSMutableSet set];
                [cancelled addObject:touch];
                break;
            default:
                break;
        }
    }
    
    // Create pseudo-event dispatch
    if (self.viewToForward && self.shouldForward) {
        if (began)
            [self.viewToForward
             touchesBegan:began withEvent:event];
        if (moved)
            [self.viewToForward
             touchesMoved:moved withEvent:event];
        if (ended)
            [self.viewToForward
             touchesEnded:ended withEvent:event];
        if (cancelled)
            [self.viewToForward
             touchesCancelled:cancelled withEvent:event];
    }
    
    // Call normal handler for default responder chain
    [super sendEvent: event];
}

@end
