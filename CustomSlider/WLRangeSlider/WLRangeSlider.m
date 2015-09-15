

#import "WLRangeSlider.h"
#import "WLSliderThumbLayer.h"
#import "WLTrackLayer.h"
#import <QuartzCore/QuartzCore.h>
#import "JWTrackLayer.h"
@interface WLRangeSlider()

@property (nonatomic,strong) WLSliderThumbLayer *leftThumbLayer;
@property (nonatomic,strong) WLSliderThumbLayer *rightThumbLayer;
@property (nonatomic,strong) WLSliderThumbLayer *leftThumbLayer1;
@property (nonatomic,strong) WLSliderThumbLayer *rightThumbLayer1;
@property (nonatomic,strong) WLTrackLayer *trackLayer;
@property(nonatomic,strong)JWTrackLayer*trackLayer1;
@property (nonatomic) CGPoint previousLoction;

@end

@implementation WLRangeSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayers];
    }
    return self;
}

- (void)initLayers{
    //z这里更改时间轴---24为24个小时
    _maxValue = 24.0;
    _minValue = 0.0;
    _leftValue = 0;
    _rightValue = 6.5;
    _leftValue1=21.0;
    _rightValue1=24;
    _thumbColor = [UIColor greenColor];
    _trackHighlightTintColor = [UIColor greenColor];
    _trackColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    _cornorRadiusScale = 1.0;
    
    _trackLayer = [WLTrackLayer layer];
    _trackLayer.contentsScale = [UIScreen mainScreen].scale;
    _trackLayer.rangeSlider = self;
    [self.layer addSublayer:_trackLayer];
    //second Layer Add by Jarvis 2015-09-14
    _trackLayer1=[JWTrackLayer layer];
    _trackLayer1.contentsScale=[UIScreen mainScreen].scale;
    _trackLayer1.rangeSlider=self;
    
    [self.layer addSublayer:_trackLayer1];
    
    _leftThumbLayer = [WLSliderThumbLayer layer];
    _leftThumbLayer.contentsScale = [UIScreen mainScreen].scale;
    _leftThumbLayer.rangeSlider = self;
    [self.layer addSublayer:_leftThumbLayer];
    
    _rightThumbLayer = [WLSliderThumbLayer layer];
    _rightThumbLayer.contentsScale = [UIScreen mainScreen].scale;
    _rightThumbLayer.rangeSlider = self;
    [self.layer addSublayer:_rightThumbLayer];
    /*************❤️❤️❤️❤️add BY  jarvis   　❤️❤️********/
    _leftThumbLayer1=[WLSliderThumbLayer layer];
    _leftThumbLayer1.contentsScale=[UIScreen mainScreen].scale;
    _leftThumbLayer1.rangeSlider=self;
    [self.layer addSublayer:_leftThumbLayer1];
    
    _rightThumbLayer1=[WLSliderThumbLayer layer];
    _rightThumbLayer1.contentsScale=[UIScreen mainScreen].scale;
    _rightThumbLayer1.rangeSlider=self;
    [self.layer addSublayer:_rightThumbLayer1];
    
    [self updateLayerFrames];
}

#pragma mark - Setters

- (void)setMinValue:(CGFloat)minValue{
    _minValue = minValue;
    [self updateLayerFrames];
}

- (void)setMaxValue:(CGFloat)maxValue{
    _maxValue = maxValue;
    [self updateLayerFrames];
}

- (void)setLeftValue:(CGFloat)leftValue{
    _leftValue = leftValue;
    [self updateLayerFrames];
}
//second control
-(void)setLeftValue1:(CGFloat)leftValue1
{
    _leftValue1=leftValue1;
    [self updateLayerFrames];
}
-(void)setRightValue1:(CGFloat)rightValue1
{
    _rightValue1=rightValue1;
    [self updateLayerFrames];
}
- (void)setRightValue:(CGFloat)rightValue{
    _rightValue = rightValue;
    [self updateLayerFrames];
}

- (void)setThumbColor:(UIColor *)thumbColor{
    _thumbColor = thumbColor;
    [_leftThumbLayer setNeedsDisplay];
    [_leftThumbLayer1 setNeedsDisplay];
    [_rightThumbLayer setNeedsDisplay];
    [_rightThumbLayer1 setNeedsDisplay];
}

- (void)setTrackColor:(UIColor *)trackColor{
    _trackColor = trackColor;
    [_trackLayer setNeedsDisplay];
    [_trackLayer1 setNeedsDisplay];
}

- (void)setTrackHighlightTintColor:(UIColor *)trackHighlightTintColor{
    _trackHighlightTintColor = trackHighlightTintColor;
    [_trackLayer setNeedsDisplay];
    [_trackLayer1 setNeedsDisplay];
}

- (void)setCornorRadiusScale:(CGFloat)cornorRadiusScale{
    _cornorRadiusScale = cornorRadiusScale;
    [_leftThumbLayer setNeedsDisplay];
    [_leftThumbLayer1 setNeedsDisplay];
    [_rightThumbLayer setNeedsDisplay];
    [_trackLayer setNeedsDisplay];
    [_trackLayer1 setNeedsDisplay];
    [_rightThumbLayer1 setNeedsDisplay];
}

#pragma mark - Utils Methods
- (CGFloat)thumbWidth{
    return CGRectGetHeight(self.bounds);
}

- (void)updateLayerFrames{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
   
    _trackLayer.frame = CGRectInset(self.bounds, 0, [self thumbWidth]/3);
    
    [_trackLayer setNeedsDisplay];
    _trackLayer1.frame=CGRectInset(self.bounds, 0, [self thumbWidth]/3);
    [_trackLayer1 setNeedsDisplay];
    
   // NSLog(@"tracker---frame====%@---%@",NSStringFromCGRect(_trackLayer.frame),NSStringFromCGRect(_trackLayer1.frame));
    
    CGFloat leftThumbCenter = [self positionForValue:_leftValue];
    CGFloat leftthumbCenter1=[self positionForValue:_leftValue1];
    _leftThumbLayer.frame = CGRectMake(leftThumbCenter - [self thumbWidth] / 2.0, 0.0, [self thumbWidth], [self thumbWidth]);
    [_leftThumbLayer setNeedsDisplay];
    _leftThumbLayer1.frame=CGRectMake(leftthumbCenter1-[self thumbWidth]/2.0, 0.0, [self thumbWidth], [self thumbWidth]);
    [_leftThumbLayer1 setNeedsDisplay];
    CGFloat rightThumbCenter = [self positionForValue:_rightValue];
    /********************************************************************/
    CGFloat rightThumbcenter1=[self positionForValue:_rightValue1];
    _rightThumbLayer.frame = CGRectMake(rightThumbCenter - [self thumbWidth] / 2.0, 0.0, [self thumbWidth], [self thumbWidth]);
    [_rightThumbLayer setNeedsDisplay];
    
    _rightThumbLayer1.frame=CGRectMake(rightThumbcenter1-[self thumbWidth]/2, 0, [self thumbWidth], [self thumbWidth]);
    [_rightThumbLayer1 setNeedsDisplay];
    
    
    [CATransaction commit];
}

- (CGFloat)positionForValue:(CGFloat)value{
    return (CGRectGetWidth(self.bounds) - [self thumbWidth]) * (value - _minValue) / (_maxValue - _minValue) + [self thumbWidth] / 2.0;
}

- (CGFloat)boundaryForValue:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue{
    return MIN(MAX(value, minValue), maxValue);
}

#pragma mark - Override Methods
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    _previousLoction = [touch locationInView:self];
    NSLog(@"begin");
    if (CGRectContainsPoint(_leftThumbLayer.frame, _previousLoction)) {
        _leftThumbLayer.highlighted = YES;
        
    }else if(CGRectContainsPoint(_rightThumbLayer.frame, _previousLoction)){
        _rightThumbLayer.highlighted = YES;
    }else if (CGRectContainsPoint(_leftThumbLayer1.frame, _previousLoction)){
        _leftThumbLayer1.highlighted=YES;
    }else if (CGRectContainsPoint(_rightThumbLayer1.frame, _previousLoction)){
        _rightThumbLayer1.highlighted=YES;
    }

    return _rightThumbLayer.highlighted || _leftThumbLayer.highlighted||_leftThumbLayer1.highlighted||_rightThumbLayer1.highlighted;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint point = [touch locationInView:self];
    CGFloat deltaX = point.x - _previousLoction.x;
    NSLog(@"continue");
    CGFloat deltaValue = (_maxValue - _minValue) * deltaX / (CGRectGetWidth(self.bounds) - [self thumbWidth]);
    _previousLoction = point;
    if (_leftThumbLayer.highlighted) {
        self.leftValue += deltaValue;
        self.leftValue = [self boundaryForValue:_leftValue minValue:_minValue maxValue:_rightValue];
    }else if (_rightThumbLayer.highlighted){
        self.rightValue += deltaValue;
        self.rightValue = [self boundaryForValue:_rightValue minValue:_leftValue maxValue:_maxValue];
    }else if (_leftThumbLayer1.highlighted){
        self.leftValue1+=deltaValue;
        self.leftValue1=[self boundaryForValue:_leftValue1 minValue:_leftValue1 maxValue:_maxValue];
    }else if (_rightThumbLayer1.highlighted){
        self.rightValue1+=deltaValue;
        self.rightValue1=[self boundaryForValue:_rightValue1 minValue:_rightValue1 maxValue:_maxValue];
    }
    if (self.leftValue==0) {
        if (self.rightValue<6.5) {
            self.rightValue=6.5;
        }
    }else if (self.leftValue>0&&self.leftValue<6){
        if (self.rightValue-self.leftValue<3) {
            self.rightValue=self.leftValue+3;
        }
        
    }
    
    if (self.leftValue1-self.rightValue<1.5) {
        NSLog(@"change1");
        self.leftValue1=self.rightValue+1.5;
        if (self.leftValue1>=21) {
            self.leftValue1=21;
            self.rightValue=21-1.5;
            if (self.leftValue>18) {
                self.leftValue=18;
                
            }
            
        }
        [self sendActionsForControlEvents: UIControlEventValueChanged];
        [self endTrackingWithTouch:touch withEvent:event];
        return NO;
    }
    if (self.rightValue-self.leftValue<1.5) {
        NSLog(@"change");
        self.rightValue=self.leftValue+1.5;
        if (self.leftValue1>21) {
            self.leftValue1=21;
            if (self.leftValue1-self.rightValue<=1.5) {
                self.rightValue=self.leftValue1-1.5;
                self.leftValue=self.rightValue-1.5;
                
            }
        }
        if (self.rightValue>19.5) {
            self.rightValue=19.5;
            if (self.leftValue>18) {
                self.leftValue=18;
            }
        }
        [self sendActionsForControlEvents: UIControlEventValueChanged];
         [self endTrackingWithTouch:touch withEvent:event];
        return NO;
       
    }
    
    if (self.rightValue1-self.leftValue1<=1.5) {
        NSLog(@"change2");
        self.rightValue1=self.leftValue1+1.5;
        if (self.rightValue1>=24) {
            self.rightValue1=24;
            self.leftValue1=21;
        }
        [self sendActionsForControlEvents: UIControlEventValueChanged];
        [self endTrackingWithTouch:touch withEvent:event];
        return NO;
    }
    [self sendActionsForControlEvents: UIControlEventValueChanged];
   
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    _leftThumbLayer.highlighted = NO;
    _rightThumbLayer.highlighted = NO;
    _leftThumbLayer1.highlighted=NO;
    _rightThumbLayer1.highlighted=NO;
    NSLog(@"end");
   
}

- (void)cancelTrackingWithEvent:(UIEvent *)event{
    _leftThumbLayer.highlighted = NO;
    _rightThumbLayer.highlighted = NO;
    _leftThumbLayer1.highlighted=NO;
    _rightThumbLayer1.highlighted=NO;
}

@end
