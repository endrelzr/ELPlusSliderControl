//
//  ELPlusSliderControl.m
//  ELPlusSliderControl
//
//  Copyright (c) 2015 Endre Lazar ( https://github.com/endrelzr )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


#import "ELPlusSliderControl.h"

@interface ELPlusSliderControl ()

@property (readwrite, nonatomic, strong) CAShapeLayer* frameLayer;
@property (readwrite, nonatomic, strong) CAShapeLayer* sliderLayer;
@property (readwrite, nonatomic, strong) CATextLayer* segmentOneTextLayer;
@property (readwrite, nonatomic, strong) CATextLayer* segmentTwoTextLayer;
@property (readwrite, nonatomic, strong) CATextLayer* segmentPlusTextLayer;

@property (readwrite, nonatomic, strong) CALayer* segmentOneImageLayer;
@property (readwrite, nonatomic, strong) CALayer* segmentTwoImageLayer;
@property (readwrite, nonatomic, strong) CALayer* segmentOneImageSelectedLayer;
@property (readwrite, nonatomic, strong) CALayer* segmentTwoImageSelectedLayer;

@end

@implementation ELPlusSliderControl{
    CGPoint beginTouchPoint;
}

#pragma mark - Init overrides
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initControl];
        [self setupControl];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]){
        [self initControl];
        [self setupControl];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self initControl];
        [self setupControl];
    }
    return self;
}

#pragma mark - Default setup and initializator

-(void) initControl{
    _plusEnabled = NO;
    
    _tintColor = [UIColor greenColor];
    _backgroundColor = [UIColor whiteColor];
    _selectedColor = [UIColor whiteColor];
    _textToImagePosition = 5.0;
    _animationDuration = 0.25;
    _cornerRadius = 1;
    _sliderPosition = ELPlusSliderPositionOne;
    _plusSelectedOpacity = 0.0;
    
    _animationTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    _segmentOneText = @"SegmOne";
    _segmentTwoText = @"SegmTwo";
    
    self.textFont = [UIFont fontWithName:@"Helvetica" size:13.0];
    
    self.layer.contentsScale = [[UIScreen mainScreen] scale];
}

- (void) setupControl{
    
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    _frameLayer = [CAShapeLayer layer];
    _frameLayer.contentsScale = self.layer.contentsScale;
    _frameLayer.bounds = self.bounds;
    _frameLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _frameLayer.fillColor = [self.backgroundColor CGColor];
    _frameLayer.strokeColor = [self.tintColor CGColor];
    _frameLayer.lineWidth = 1.0;
    _frameLayer.path = [[UIBezierPath bezierPathWithRoundedRect: _frameLayer.bounds cornerRadius: self.cornerRadius ] CGPath];
    [self.layer addSublayer:_frameLayer];
    
    _sliderLayer = [CAShapeLayer layer];
    _sliderLayer.contentsScale = self.layer.contentsScale;
    _sliderLayer.fillColor = [self.tintColor CGColor];
    _sliderLayer.strokeColor = [self.tintColor CGColor];
    _sliderLayer.bounds = CGRectMake(0, 0, self.bounds.size.width / (2.0 + (_plusEnabled?1.0:0.0)), self.bounds.size.height);
    _sliderLayer.lineWidth = 1.0;
    _sliderLayer.position = CGPointMake(CGRectGetMinX(self.bounds) + _sliderLayer.bounds.size.width / 2.0, CGRectGetMidY(self.bounds));
    _sliderLayer.path = [[UIBezierPath bezierPathWithRoundedRect:_sliderLayer.bounds cornerRadius:self.cornerRadius] CGPath];
    [self.layer addSublayer:_sliderLayer];
    
    _segmentOneTextLayer = [CATextLayer layer];
    _segmentOneTextLayer.contentsScale = self.layer.contentsScale;
    _segmentOneTextLayer.string = self.segmentOneText;
    _segmentOneTextLayer.foregroundColor = [self.selectedColor CGColor];
    _segmentOneTextLayer.alignmentMode = kCAAlignmentLeft;
    [self.layer addSublayer:_segmentOneTextLayer];
    
    _segmentTwoTextLayer = [CATextLayer layer];
    _segmentTwoTextLayer.contentsScale = self.layer.contentsScale;
    _segmentTwoTextLayer.string = self.segmentTwoText;
    _segmentTwoTextLayer.foregroundColor = [self.selectedColor CGColor];
    _segmentTwoTextLayer.alignmentMode = kCAAlignmentLeft;
    [self.layer addSublayer:_segmentTwoTextLayer];
    
    _segmentTwoImageLayer = [CALayer layer];
    _segmentTwoImageLayer.contentsScale = self.layer.contentsScale;
    _segmentTwoImageLayer.backgroundColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer: _segmentTwoImageLayer];
    
    _segmentPlusTextLayer = [CATextLayer layer];
    _segmentPlusTextLayer.foregroundColor = [self.tintColor CGColor];
    _segmentPlusTextLayer.contentsScale = self.layer.contentsScale;
    _segmentPlusTextLayer.string = @"+";
    _segmentPlusTextLayer.alignmentMode = kCAAlignmentCenter;
    _segmentPlusTextLayer.bounds = CGRectMake(0, 0, self.frameLayer.bounds.size.height, self.frameLayer.bounds.size.height);
    _segmentPlusTextLayer.anchorPoint = CGPointMake( 0.5, 0.7);
    _segmentPlusTextLayer.fontSize = _segmentPlusTextLayer.bounds.size.height;
    _segmentPlusTextLayer.position = CGPointMake(_frameLayer.position.x, _frameLayer.position.y  );
    _segmentPlusTextLayer.transform = self.plusEnabled ? CATransform3DIdentity : CATransform3DMakeScale(0.000001, 0.0000001, 1.0);
    [self.layer addSublayer:_segmentPlusTextLayer];
    
    [self positionateTextAndImage];
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(controlTapped:)];
    [self addGestureRecognizer:_tapGestureRecognizer];
    
    [self setPosition:self.sliderPosition animated:NO];
    
}

- (void) positionateTextAndImage{
    
    CGSize textOneSize = [self.segmentOneText sizeWithAttributes:@{NSFontAttributeName: self.textFont}];
    CGSize textTwoSize = [self.segmentTwoText sizeWithAttributes:@{NSFontAttributeName: self.textFont}];
    
    CGPoint textOnePosition;
    CGPoint imageOnePosition;
    CGPoint textTwoPosition;
    CGPoint imageTwoPosition;
    
    if (self.segmentOneImage){
        imageOnePosition = CGPointMake((_sliderLayer.bounds.size.width - textOneSize.width - self.segmentOneImage.size.width - self.textToImagePosition) / 2.0 +  self.segmentOneImage.size.width / 2.0, _frameLayer.bounds.size.height / 2.0);
        textOnePosition = CGPointMake((_sliderLayer.bounds.size.width - textOneSize.width - self.segmentOneImage.size.width - self.textToImagePosition) / 2.0 +  self.segmentOneImage.size.width + self.textToImagePosition + textOneSize.width / 2.0,  _frameLayer.bounds.size.height / 2.0);
    } else {
        textOnePosition = CGPointMake(_sliderLayer.bounds.size.width / 2.0, _frameLayer.bounds.size.height / 2.0);
    }
    
    if (self.segmentTwoImage){
        imageTwoPosition = CGPointMake( self.bounds.size.width - _sliderLayer.bounds.size.width + (_sliderLayer.bounds.size.width - textTwoSize.width - self.segmentOneImage.size.width - self.textToImagePosition) / 2.0 +  self.segmentOneImage.size.width / 2.0, _frameLayer.bounds.size.height / 2.0);
        textTwoPosition = CGPointMake( self.bounds.size.width - _sliderLayer.bounds.size.width + (_sliderLayer.bounds.size.width - textTwoSize.width - self.segmentOneImage.size.width - self.textToImagePosition) / 2.0 +  self.segmentOneImage.size.width + self.textToImagePosition + textTwoSize.width / 2.0,  _frameLayer.bounds.size.height / 2.0);
    } else {
        textTwoPosition = CGPointMake(self.bounds.size.width - _sliderLayer.bounds.size.width / 2.0, _frameLayer.bounds.size.height / 2.0);
    }
    
    _segmentOneTextLayer.position = textOnePosition;
    _segmentOneTextLayer.bounds = CGRectMake(0, 0, textOneSize.width , textOneSize.height + 2);
    _segmentOneTextLayer.font =  CGFontCreateWithFontName((CFStringRef)self.textFont.fontName);
    _segmentOneTextLayer.fontSize = self.textFont.pointSize;
    _segmentOneTextLayer.string = _segmentOneText;
    
    _segmentTwoTextLayer.position = textTwoPosition;
    _segmentTwoTextLayer.bounds = CGRectMake(0, 0, textTwoSize.width , textTwoSize.height + 2);
    _segmentTwoTextLayer.font =  CGFontCreateWithFontName((CFStringRef)self.textFont.fontName);
    _segmentTwoTextLayer.fontSize = self.textFont.pointSize;
    _segmentTwoTextLayer.string = _segmentTwoText;
    
    if (self.segmentOneImage) {
        _segmentOneImageLayer.contents = (id)([self.segmentOneImage CGImage]);
        _segmentOneImageLayer.bounds = CGRectMake(0, 0, self.segmentOneImage.size.width , self.segmentOneImage.size.height);
        _segmentOneImageLayer.position = imageOnePosition;
    }
    
    if (self.segmentTwoImage) {
        _segmentTwoImageLayer.contents = (id)([self.segmentTwoImage CGImage]);
        _segmentTwoImageLayer.bounds = CGRectMake(0, 0, self.segmentTwoImage.size.width , self.segmentTwoImage.size.height);
        _segmentTwoImageLayer.position = imageTwoPosition;
    }
    
    if (self.segmentOneImageSelected) {
        _segmentOneImageSelectedLayer.contents = (id) ([self.segmentOneImageSelected CGImage]);
        _segmentOneImageSelectedLayer.bounds = CGRectMake(0, 0, self.segmentOneImageSelected.size.width , self.segmentOneImageSelected.size.height);
        _segmentOneImageSelectedLayer.position = imageOnePosition;
        
        _segmentOneImageSelectedLayer.opacity = (self.sliderPosition == ELPlusSliderPositionOne)?1.0:0.0;
    }
    
    if (self.segmentTwoImageSelected) {
        _segmentTwoImageSelectedLayer.contents = (id) ([self.segmentTwoImageSelected CGImage]);
        _segmentTwoImageSelectedLayer.bounds = CGRectMake(0, 0, self.segmentTwoImageSelected.size.width , self.segmentTwoImageSelected.size.height);
        _segmentTwoImageSelectedLayer.position = imageTwoPosition;
        
        _segmentTwoImageSelectedLayer.opacity = (self.sliderPosition == ELPlusSliderPositionTwo)?1.0:0.0;
        
    }
}

#pragma mark - Public setters

-(void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    _frameLayer.strokeColor = [_tintColor CGColor];
    _sliderLayer.fillColor = [_tintColor CGColor];
    _sliderLayer.strokeColor = [_tintColor CGColor];
    
    _segmentOneTextLayer.foregroundColor = (self.sliderPosition == ELPlusSliderPositionOne) ? [self.selectedColor CGColor] : [self.tintColor CGColor];
    _segmentTwoTextLayer.foregroundColor = (self.sliderPosition == ELPlusSliderPositionTwo) ? [self.selectedColor CGColor] : [self.tintColor CGColor];
    _segmentPlusTextLayer.foregroundColor = (self.sliderPosition == ELPlusSliderPositionPlus) ? [self.selectedColor CGColor] : [self.tintColor CGColor];
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    
    if (self.sliderPosition == ELPlusSliderPositionOne) _segmentOneTextLayer.foregroundColor = [self.selectedColor CGColor];
    if (self.sliderPosition == ELPlusSliderPositionTwo) _segmentTwoTextLayer.foregroundColor = [self.selectedColor CGColor];
    if (self.sliderPosition == ELPlusSliderPositionPlus) _segmentPlusTextLayer.foregroundColor = [self.selectedColor CGColor];
    
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    _frameLayer.fillColor = [backgroundColor CGColor];
    self.layer.backgroundColor = [backgroundColor CGColor];
}

-(void)setSegmentOneImage:(UIImage *)segmentOneImage{
    _segmentOneImage = segmentOneImage;
    
    _segmentOneImageLayer = [CALayer layer];
    _segmentOneImageLayer.contentsScale = self.layer.contentsScale;
    _segmentOneImageLayer.backgroundColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer: _segmentOneImageLayer];
    
    [self positionateTextAndImage];
    
}

-(void)setSegmentTwoImage:(UIImage *)segmentTwoImage{
    _segmentTwoImage = segmentTwoImage;
    
    [self positionateTextAndImage];
    
}

-(void)setSegmentOneImageSelected:(UIImage *)segmentOneImageSelected{
    _segmentOneImageSelected = segmentOneImageSelected;
    
    _segmentOneImageSelectedLayer = [CALayer layer];
    _segmentOneImageSelectedLayer.contentsScale = self.layer.contentsScale;
    _segmentOneImageSelectedLayer.backgroundColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer:_segmentOneImageSelectedLayer];
    
    [self positionateTextAndImage];
}

-(void)setSegmentTwoImageSelected:(UIImage *)segmentTwoImageSelected{
    _segmentTwoImageSelected = segmentTwoImageSelected;
    
    _segmentTwoImageSelectedLayer = [CALayer layer];
    _segmentTwoImageSelectedLayer.contentsScale = self.layer.contentsScale;
    _segmentTwoImageSelectedLayer.backgroundColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer:_segmentTwoImageSelectedLayer];
    
    [self positionateTextAndImage];
}

-(void)setSegmentOneText:(NSString *)segmentOneText{
    _segmentOneText = segmentOneText;
    
    [self positionateTextAndImage];
}

-(void)setSegmentTwoText:(NSString *)segmentTwoText{
    _segmentTwoText = segmentTwoText;
    
    [self positionateTextAndImage];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    
    [self setupControl];
}

-(void)setPlusEnabled:(BOOL)plusEnabled{
    [self setPlusEnabled:plusEnabled animated:NO];
}

-(void) setPlusEnabled:(BOOL)plusEnabled animated:(BOOL) animated{
   
    _plusEnabled = plusEnabled;
    
    // Prepare for enable
    _segmentPlusTextLayer.foregroundColor = [self.tintColor CGColor];
    CGFloat plusFrom = plusEnabled ? 0.00001 : 1.0;
    _segmentPlusTextLayer.transform = CATransform3DMakeScale(plusFrom, plusFrom, 1.0);
    
    // COnfigure animation
    [CATransaction begin];
    [CATransaction setAnimationDuration: animated? self.animationDuration : 0.0000001];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:_animationTimingFunction];
    
    // Animate slider
    _sliderLayer.bounds = CGRectMake(0, 0, _frameLayer.bounds.size.width / (2.0 + ( _plusEnabled ? 1.0 : 0.0)), self.bounds.size.height);
    _sliderLayer.position = CGPointMake(CGRectGetMinX(self.bounds) + _sliderLayer.bounds.size.width / 2.0, CGRectGetMidY(self.bounds));
    _sliderLayer.transform = CATransform3DMakeTranslation(self.sliderPositionFraction * _sliderLayer.bounds.size.width * ( _plusEnabled ? 2.0 : 1.0), 0, 0);
    
    // Animate plus sign
    CGFloat plusTo = plusEnabled ? 1.0 : 0.00001;
    _segmentPlusTextLayer.transform = CATransform3DMakeScale(plusTo, plusTo, 1.0);
    
    if (self.sliderPosition == ELPlusSliderPositionPlus) {
        _frameLayer.fillColor = [self.backgroundColor CGColor];
    }
    
    // Animate texts
    [self positionateTextAndImage];
    
    [CATransaction commit];
    
    // Animate shape
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = ( id) _sliderLayer.path;
    pathAnimation.toValue = ( id) [[UIBezierPath bezierPathWithRoundedRect:_sliderLayer.bounds cornerRadius:self.cornerRadius] CGPath];
    pathAnimation.duration = animated? self.animationDuration : 0.0000001;
    [pathAnimation setTimingFunction:_animationTimingFunction];
    [_sliderLayer addAnimation:pathAnimation forKey:@"path"];
    
    // Save path
    _sliderLayer.path = [[UIBezierPath bezierPathWithRoundedRect:_sliderLayer.bounds cornerRadius:self.cornerRadius] CGPath];
    
    // Move slider to position one if on plus
    if (self.sliderPosition == ELPlusSliderPositionPlus) {
        [self setPosition:ELPlusSliderPositionOne animated:YES];
    }
}

-(void)setPosition:(ELPlusSliderPosition)position animated:(BOOL) animated{
    
    if (position == ELPlusSliderPositionOne) {
        [self setPositionForOffset:0.0 animated:animated];
    }
    
    if (position == ELPlusSliderPositionTwo) {
        [self setPositionForOffset:1.0 animated:animated];
    }
    
    if (self.plusEnabled && position == ELPlusSliderPositionPlus) {
        [self setPositionForOffset:0.5 animated:animated];
    }
    
}


#pragma mark - Private manipulators

- (void) setPositionForOffset:(CGFloat) offset animated:(BOOL) animated{
    _sliderPositionFraction = offset;
    
    [CATransaction begin];
    [CATransaction setAnimationDuration: animated? self.animationDuration : 0.0];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:_animationTimingFunction];
    
    if (self.plusEnabled){
        _sliderLayer.transform = CATransform3DMakeTranslation(offset * _sliderLayer.bounds.size.width * 2, 0, 0);
        
        CGFloat segmentOneColorOffset = (offset < 0.5) ? offset * 2.0 : 1.0;
        CGFloat segmentTwoColorOffset = (offset > 0.5) ? (1.0 - offset) * 2.0 : 1.0;
        CGFloat segmentPlusColorOffset = (offset < 0.5) ? 1.0 - segmentOneColorOffset : 1 - segmentTwoColorOffset;
        CGFloat backgroundColorOffset = (offset < 0.5) ? offset * 2.0 : (1.0 - offset) * 2 ;
        
        _segmentOneTextLayer.foregroundColor = [self colorFromColor:self.selectedColor toColor:self.tintColor percent:segmentOneColorOffset].CGColor;
        _segmentTwoTextLayer.foregroundColor = [self colorFromColor:self.selectedColor toColor:self.tintColor percent:segmentTwoColorOffset].CGColor;
        
        _segmentPlusTextLayer.foregroundColor = [self colorFromColor:self.selectedColor toColor:self.tintColor percent:segmentPlusColorOffset].CGColor;
        
        _segmentOneImageSelectedLayer.opacity = 1 - segmentOneColorOffset;
        _segmentTwoImageSelectedLayer.opacity = 1 - segmentTwoColorOffset;
        
        _frameLayer.fillColor = [[self colorFromColor:self.backgroundColor toColor:self.tintColor percent:backgroundColorOffset * self.plusSelectedOpacity] CGColor];
        
    } else{
        _sliderLayer.transform = CATransform3DMakeTranslation(offset * _sliderLayer.bounds.size.width, 0, 0);
        _segmentOneTextLayer.foregroundColor = [self colorFromColor:self.selectedColor toColor:self.tintColor percent:offset].CGColor;
        _segmentTwoTextLayer.foregroundColor = [self colorFromColor:self.selectedColor toColor:self.tintColor percent:1 - offset].CGColor;
        
        _segmentOneImageSelectedLayer.opacity = 1.0 - offset;
        _segmentTwoImageSelectedLayer.opacity = offset;
    }
    
    [CATransaction commit];
    
    if (!self.tracking) {
        if (offset == 0.0) {
            _sliderPosition = ELPlusSliderPositionOne;
        } else if (offset == 1.0)
            _sliderPosition = ELPlusSliderPositionTwo;
        else if (offset == 0.5)
            _sliderPosition = ELPlusSliderPositionPlus;
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}

#pragma mark - Tap gesture recognizer

- (void) controlTapped: (UITapGestureRecognizer*) recognizer{
    // Get the location of the gesture
    CGPoint location = [recognizer locationInView:self];
    
    if (self.plusEnabled){
        if (CGRectContainsPoint(self.bounds, location)) {
            CGRect segmentOneRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width / 3.0, self.bounds.size.height);
            CGRect segmentTwoRect = CGRectMake(self.bounds.origin.x + self.bounds.size.width / 3.0 * 2, self.bounds.origin.y, self.bounds.size.width / 3.0, self.bounds.size.height);
            
            if (CGRectContainsPoint(segmentOneRect, location))
                [self setPositionForOffset:0.0 animated:YES];
            else if (CGRectContainsPoint(segmentTwoRect, location))
                [self setPositionForOffset:1.0 animated:YES];
            else
                [self setPositionForOffset:0.5 animated:YES];
        }
    } else {
        if (CGRectContainsPoint(self.bounds, location)) {
            [self setPositionForOffset:(location.x < self.bounds.size.width / 2.0) ? 0.0f : 1.0f  animated:YES];
        }
    }
}

#pragma mark - Touch tracking

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super beginTrackingWithTouch:touch withEvent:event];
    
    beginTouchPoint = [touch locationInView:self];
    
    if (CGRectContainsPoint(_sliderLayer.frame, beginTouchPoint))
    {
        self.tapGestureRecognizer.enabled = false;
        return YES;
    }
    else{
        return NO;
    }
    
}


-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint currentTouchPoint = [touch locationInView:self];
    CGPoint delta = CGPointMake(currentTouchPoint.x - beginTouchPoint.x, currentTouchPoint.y - beginTouchPoint.y);
    
    
    if  (self.plusEnabled){
        
        CGRect segmentOneRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width / 3.0, self.bounds.size.height);
        CGRect segmentPlusRect = CGRectMake(self.bounds.origin.x + self.bounds.size.width / 3.0, self.bounds.origin.y, self.bounds.size.width / 3.0, self.bounds.size.height);
        
        float startOffsetX = 0.0;
        if (CGRectContainsPoint(segmentOneRect, beginTouchPoint)){
            startOffsetX = 0.0;
        } else if (CGRectContainsPoint(segmentPlusRect, beginTouchPoint)) {
            startOffsetX = 0.5;
        } else {
            startOffsetX = 1.0;
        }
        
        float offsetX = delta.x / (_sliderLayer.bounds.size.width * 2) + startOffsetX;
        if (offsetX < 0.0) offsetX = 0.0;
        if (offsetX > 1.0) offsetX = 1.0;
        
        [self setPositionForOffset:offsetX animated:NO];
        
        
    }else{
        float offsetX = delta.x / _sliderLayer.bounds.size.width;
        
        if (beginTouchPoint.x < self.bounds.size.width / 2.0) {
            if (offsetX < 0.0) offsetX = 0.0;
            if (offsetX > 1.0) offsetX = 1.0;
            
            [self setPositionForOffset:offsetX animated:NO];
        } else {
            if (offsetX > 0.0) offsetX = 0.0;
            if (offsetX < -1.0) offsetX = -1.0;
            
            [self setPositionForOffset:1.0 + offsetX animated:NO];
        }
        
    }
    
    return  YES;
}


-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    
    if (self.plusEnabled) {
        if (self.sliderPositionFraction <= 0.25)
            [self setPosition:ELPlusSliderPositionOne animated:YES];
        else if (self.sliderPositionFraction >= 0.75)
            [self setPosition:ELPlusSliderPositionTwo animated:YES];
        else
            [self setPosition:ELPlusSliderPositionPlus animated:YES];
    }else{
        
        if (self.sliderPositionFraction < 0.5)
            [self setPosition:ELPlusSliderPositionOne animated:YES];
        else
            [self setPosition:ELPlusSliderPositionTwo animated:YES];
    }
    self.tapGestureRecognizer.enabled = true;
}

-(void)cancelTrackingWithEvent:(UIEvent *)event
{
    if (self.plusEnabled) {
        if (self.sliderPositionFraction <= 0.25)
            [self setPosition:ELPlusSliderPositionOne animated:YES];
        else if (self.sliderPositionFraction >= 0.75)
            [self setPosition:ELPlusSliderPositionTwo animated:YES];
        else
            [self setPosition:ELPlusSliderPositionPlus animated:YES];
    }else{
        
        if (self.sliderPositionFraction < 0.5)
            [self setPosition:ELPlusSliderPositionOne animated:YES];
        else
            [self setPosition:ELPlusSliderPositionTwo animated:YES];
    }
    
    self.tapGestureRecognizer.enabled = true;
}


#pragma mark - Helper function

- (UIColor *)colorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(float)percent
{
    float dec = percent;
    CGFloat fRed, fBlue, fGreen, fAlpha;
    CGFloat tRed, tBlue, tGreen, tAlpha;
    CGFloat red, green, blue, alpha;
    
    if(CGColorGetNumberOfComponents(fromColor.CGColor) == 2) {
        [fromColor getWhite:&fRed alpha:&fAlpha];
        fGreen = fRed;
        fBlue = fRed;
    }
    else {
        [fromColor getRed:&fRed green:&fGreen blue:&fBlue alpha:&fAlpha];
    }
    if(CGColorGetNumberOfComponents(toColor.CGColor) == 2) {
        [toColor getWhite:&tRed alpha:&tAlpha];
        tGreen = tRed;
        tBlue = tRed;
    }
    else {
        [toColor getRed:&tRed green:&tGreen blue:&tBlue alpha:&tAlpha];
    }
    
    red = (dec * (tRed - fRed)) + fRed;
    green = (dec * (tGreen - fGreen)) + fGreen;
    blue = (dec * (tBlue - fBlue)) + fBlue;
    alpha = (dec * (tAlpha - fAlpha)) + fAlpha;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
