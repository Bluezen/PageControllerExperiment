//
//  MyScrollview.m
//  PageExperiment
//
//  Created by Adrien Long on 03/05/2016.
//  Copyright © 2016 Adrien Long. All rights reserved.
//

#import "MyScrollview.h"

@implementation MyScrollview

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.shouldLog = NO;
    
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
//    NSLog(@"Point Inside");
    
    return [super pointInside:point withEvent:event];
}

- (BOOL) touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    if (self.shouldLog)
        NSLog(@"Touch should BEGIN in View %@", view);
    
    return [super touchesShouldBegin:touches withEvent:event inContentView:view];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if (self.shouldLog)
    NSLog(@"Touch should CANCEL in View %@", view);
    
    return [super touchesShouldCancelInContentView:view];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.shouldLog)
    NSLog(@"Touch Began");
    
    // If not dragging, send event to next responder
//    if (!self.dragging) {
    
//        [self.nextResponder touchesBegan: touches withEvent:event];
    
//    } else {
        [super touchesBegan: touches withEvent: event];
//    }
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.shouldLog)
    NSLog(@"Touch Moved");
    
    // If not dragging, send event to next responder
//    if (!self.dragging){
    
//        [self.nextResponder touchesMoved: touches withEvent:event];
    
//    } else {
        [super touchesMoved: touches withEvent: event];
//    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.shouldLog)
    NSLog(@"Touch Ended");
    
    // If not dragging, send event to next responder
//    if (!self.dragging){
    
//        [self.nextResponder touchesEnded: touches withEvent:event];
    
//    } else {
        [super touchesEnded: touches withEvent: event];
//    }
}

@end
