# ELPlusSliderControl

Flat style two segment slider, with optional plus segment. 

## Requirements
* Xcode 6 or higher
* Apple LLVM compiler
* iOS 7.0 or higher
* ARC


##Installation

Currently you can install it only manually by copying these two files to your project: ELPlusSliderControl.h and ELPlusSliderControl.m

### Usage

 In order to use ELPlusSliderControl, you can instantiate it programmatically. Once you have an instance, you can use the control properties to configure it.

Example:

```
 	self.slider = [[ELPlusSliderControl alloc ] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, 40)];
    self.slider.plusEnabled = YES;
    self.slider.tintColor = [UIColor greenColor];;
    self.slider.backgroundColor = [UIColor whiteColor];
    self.slider.cornerRadius = 20;
    self.slider.plusSelectedOpacity = 0.1;
    self.slider.segmentOneImage = [UIImage imageNamed:...];
    self.slider.segmentOneImageSelected = [UIImage imageNamed:...];
    self.slider.segmentTwoImage = [UIImage imageNamed:...];
    self.slider.segmentTwoImageSelected = [UIImage imageNamed:...];
    [self.slider addTarget:self action:@selector(sliderEvent:) forControlEvents:UIControlEventAllEvents];

```

## Screenshots



## Contact

Endre Lázár

- https://github.com/endrelzr
- endre89@gmail.com

## License

ELPlusSliderControl is available under the MIT license.

Copyright © 2015 Endre Lázár.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
