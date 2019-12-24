//
//  XJSlider.m
//  XJMesh-iOS
//
//  Created by 王小胜 on 2019/12/19.
//  Copyright © 2019 王小胜. All rights reserved.
//

#import "XJSlider.h"
#define thumbBound_x 10
#define thumbBound_y 20

@interface XJSlider()
@property (nonatomic, assign) CGRect lastBounds;
@end

@implementation XJSlider

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    rect.origin.x = rect.origin.x-10;
    rect.size.width = rect.size.width + 20;
    CGRect result = [super thumbRectForBounds:bounds trackRect:rect value:value];
    _lastBounds = result;
    return result;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL result = [super pointInside:point withEvent:event];
    if (!result && point.y > -10) {
        if ((point.x >= _lastBounds.origin.x - thumbBound_x) && (point.x <= (_lastBounds.origin.x + _lastBounds.size.width + thumbBound_x)) && (point.y < (_lastBounds.size.height + thumbBound_y))) {
            result = YES;
        }
        
    }
    return result;
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(0,(self.frame.size.height-10)*0.5,self.frame.size.width,4);
}
@end
