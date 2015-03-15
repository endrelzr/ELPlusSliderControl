//
//  ELPlusSliderControl.h
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

#import <UIKit/UIKit.h>

typedef enum {
    ELPlusSliderPositionOne,
    ELPlusSliderPositionTwo,
    ELPlusSliderPositionPlus,
} ELPlusSliderPosition ;

@interface ELPlusSliderControl : UIControl

@property (assign, readwrite, nonatomic) BOOL plusEnabled;
@property (assign, readwrite, nonatomic) CGFloat plusSelectedOpacity;

/**
 *  Drawing properties
 */
@property (assign, readwrite, nonatomic) CGFloat cornerRadius;
@property (assign, readwrite, nonatomic) CGFloat textToImagePosition;
/**
 *  Color properties
 */
@property (strong, readwrite, nonatomic) UIColor* selectedColor;
@property (strong, readwrite, nonatomic) UIColor* tintColor;
@property (strong, readwrite, nonatomic) UIColor* backgroundColor;
/**
 *  Text properties
 */
@property (strong, readwrite, nonatomic) UIFont* textFont;
@property (strong, readwrite, nonatomic) NSString* segmentOneText;
@property (strong, readwrite, nonatomic) NSString* segmentTwoText;
/**
 *  Image properties
 */
@property (strong, readwrite, nonatomic) UIImage* segmentOneImage;
@property (strong, readwrite, nonatomic) UIImage* segmentOneImageSelected;
@property (strong, readwrite, nonatomic) UIImage* segmentTwoImage;
@property (strong, readwrite, nonatomic) UIImage* segmentTwoImageSelected;

/**
 *  Animation properties
 */
@property (assign, readwrite, nonatomic) float animationDuration;
@property (assign, readwrite, nonatomic) CAMediaTimingFunction* animationTimingFunction;
/**
 *  Only getters
 */
@property (assign, readonly, nonatomic) ELPlusSliderPosition sliderPosition;
@property (assign, readonly, nonatomic) float sliderPositionFraction;


@property (strong, readonly, nonatomic) UITapGestureRecognizer* tapGestureRecognizer;


-(void)setPosition:(ELPlusSliderPosition)position animated:(BOOL) animated;
-(void)setPlusEnabled:(BOOL)plusEnabled animated:(BOOL) animated;


@end
