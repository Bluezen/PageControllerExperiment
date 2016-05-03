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
    
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"Point Inside");
    
    return [super pointInside:point withEvent:event];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
    NSLog(@"Touch Ended");
    
    // If not dragging, send event to next responder
//    if (!self.dragging){
    
//        [self.nextResponder touchesEnded: touches withEvent:event];
    
//    } else {
        [super touchesEnded: touches withEvent: event];
//    }
}

@end
