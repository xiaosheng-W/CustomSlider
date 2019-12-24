//
//  XJSliderView.m
//  XJMesh-iOS
//
//  Created by 王小胜 on 2019/12/19.
//  Copyright © 2019 王小胜. All rights reserved.
//

#import "XJSliderView.h"
#import "XJSlider.h"
#import <RGUIKit/RGUIKit.h>

@interface XJSliderView()
@property (nonatomic, strong) XJSlider *slider;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *valueLable;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CAGradientLayer *grayLayer;
@end

@implementation XJSliderView
- (NSArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSArray array];
    }
    return _colorArray;
}

- (NSArray *)locationArray {
    if (!_locationArray) {
        _locationArray = [NSArray array];
    }
    return _locationArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 20)];
    self.titleLable.font = [UIFont systemFontOfSize:14];
    self.titleLable.textColor = [UIColor rg_colorWithRGBHex:0x333333];
    [self addSubview:self.titleLable];
    
    self.valueLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 55, 20)];
    self.valueLable.textColor = [UIColor rg_colorWithRGBHex:0x1D2023];
    self.valueLable.font = [UIFont systemFontOfSize:14];
    self.valueLable.center = CGPointMake(20, self.bounds.size.height - 45);
    self.valueLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.valueLable];
    
    self.slider = [[XJSlider alloc]initWithFrame:CGRectMake(20, self.bounds.size.height - 35, self.bounds.size.width - 40, 30)];
    self.slider.maximumValue = 100.0;
    self.slider.minimumValue = 1.0;
    [self.slider addTarget:self action:@selector(touchSlider:forEvent:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.slider];
}

- (void)setType:(SliderType)type {
    _type = type;
    if (type == Nomal) {
        self.slider.minimumTrackTintColor = self.minimumTrackTintColor;
        self.slider.maximumTrackTintColor = self.maximumTrackTintColor;
    }
    
    if (type == Gradient) {
        if (self.colorArray.count > 0 && self.locationArray.count > 0) {
            self.slider.minimumTrackTintColor=[UIColor clearColor];
            self.slider.maximumTrackTintColor=[UIColor clearColor];
            self.gradientLayer =  [CAGradientLayer layer];
            self.gradientLayer.frame = CGRectMake(0,11,self.bounds.size.width - 40, 4);
            self.gradientLayer.masksToBounds = YES;
            self.gradientLayer.cornerRadius = 2;
            self.gradientLayer.borderColor = [UIColor rg_colorWithRGBHex:0xD6D8DB].CGColor;
            self.gradientLayer.borderWidth = 0.2;
            [self.gradientLayer setLocations:self.locationArray];
            [self.gradientLayer setColors:self.colorArray];
            [self.gradientLayer setStartPoint:CGPointMake(0, 0)];
            [self.gradientLayer setEndPoint:CGPointMake(1, 0)];
            [self.slider.layer addSublayer:self.gradientLayer];
        }
    }
}

- (void)setMaximumValue:(int)maximumValue {
    _maximumValue = maximumValue;
    
}

- (void)setMinimumValue:(int)minimumValue {
    _minimumValue = minimumValue;
    if (self.unit.length > 0) {
        self.valueLable.text = [NSString stringWithFormat:@"%d%@", minimumValue, self.unit];
    }else{
        self.valueLable.text = [NSString stringWithFormat:@"%d%%", minimumValue];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLable.text = title;
}

- (void)setIsShowValue:(BOOL)isShowValue {
    _isShowValue = isShowValue;
    self.valueLable.hidden = !isShowValue;
}

- (void)setIsRound:(BOOL)isRound {
    _isRound = isRound;
    self.layer.cornerRadius = 5;
}

- (void)touchSlider:(UISlider *)sender forEvent:(UIEvent *)event {
    float lengh = (float)(self.maximumValue - self.minimumValue);
    float sliderLengh = sender.maximumValue - sender.minimumValue;
    float unitValue = lengh/sliderLengh;
    int value = (int)(sender.value -1.0)*unitValue + self.minimumValue;
    
    if (self.unit.length > 0) {
        self.valueLable.text = [NSString stringWithFormat:@"%d%@", value, self.unit];
    }else{
        self.valueLable.text = [NSString stringWithFormat:@"%d%%", value];
    }
    self.valueLable.center = CGPointMake((self.slider.frame.size.width/(sender.maximumValue-sender.minimumValue))*(sender.value  -1) + 20, self.bounds.size.height - 45);
    UIColor *color;
    if (sender.value < 99.0) {
        color = [self colorOfPoint:CGPointMake(sender.frame.size.width*(sender.value/100), 2) gradientLayer:self.gradientLayer];
    }else{
        if (self.colorArray.count > 0) {
            CGColorRef cgColor = (__bridge CGColorRef)(self.colorArray.lastObject);
            color = [UIColor colorWithCGColor:cgColor];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderValueColor:tag:)]) {
        [self.delegate sliderValueColor:color tag:self.tag];
    }
    
    UITouch *touchEvent = [[event allTouches] anyObject];
    if (touchEvent.phase == UITouchPhaseEnded) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sliderValue:tag:)]) {
            [self.delegate sliderValue:value tag:self.tag];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(originalSliderValue:tag:)]) {
            [self.delegate originalSliderValue:(int)sender.value tag:self.tag];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(sliderColorPhaseEnded:tag:)]) {
            [self.delegate sliderColorPhaseEnded:color tag:self.tag];
        }
    }
}

- (UIColor *)colorOfPoint:(CGPoint)point gradientLayer:(CAGradientLayer *)gradientLayer{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [gradientLayer renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}


#warning 待定默认值sliderValue
- (void)setCurrentValue:(int)currentValue {
    _currentValue = currentValue;
    CGFloat unitValue = 99.0/(float)(self.maximumValue - self.minimumValue);
    CGFloat value = (float)currentValue*unitValue;
    self.valueLable.center = CGPointMake((self.slider.frame.size.width/99.0)*(value  -1) + 20, self.bounds.size.height - 45);
    if (self.unit.length > 0) {
        self.valueLable.text = [NSString stringWithFormat:@"%d%@", currentValue, self.unit];
    }else{
        self.valueLable.text = [NSString stringWithFormat:@"%d%%", currentValue];
    }
    [self.slider setValue:value];
    
    UIColor *color;
    if (value < 99.0) {
        color = [self colorOfPoint:CGPointMake(self.slider.frame.size.width*(value/100), 4) gradientLayer:self.gradientLayer];
    }else{
        if (self.colorArray.count > 0) {
            CGColorRef cgColor = (__bridge CGColorRef)(self.colorArray.lastObject);
            color = [UIColor colorWithCGColor:cgColor];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderValueColor:tag:)]) {
        [self.delegate sliderValueColor:color tag:self.tag];
    }
}

- (void)setIsGrayState:(BOOL)isGrayState {
    _isGrayState = isGrayState;
    if (isGrayState) {
        self.userInteractionEnabled = NO;
        self.valueLable.textColor = [UIColor rg_colorWithRGBHex:0xC5C9D3];
        self.slider.minimumTrackTintColor = [UIColor rg_colorWithRGBHex:0xC5C9D3];
        self.slider.maximumTrackTintColor = [UIColor rg_colorWithRGBHex:0xC5C9D3];
        [self.gradientLayer removeFromSuperlayer];
    }else{
        self.valueLable.textColor = [UIColor rg_colorWithRGBHex:0x1D2023];
        self.userInteractionEnabled = YES;
        if (self.type == Gradient) {
            self.slider.minimumTrackTintColor = [UIColor clearColor];
            self.slider.maximumTrackTintColor = [UIColor clearColor];
        }
        [self.slider.layer insertSublayer:self.gradientLayer atIndex:0];
    }
}
@end
