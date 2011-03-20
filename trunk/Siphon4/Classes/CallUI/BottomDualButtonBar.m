/**
 *  Siphon SIP-VoIP for iPhone and iPod Touch
 *  Copyright (C) 2008-2011 Samuel <samuelv0304@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#import "BottomDualButtonBar.h"
#import "BottomButtonBar.h"
#import "BottomBar.h"


@implementation BottomDualButtonBar

@synthesize button = _button;
@synthesize button2 = _button2;

- (id)initWithDefaultSize
{
  CGRect rect = CGRectMake(DEFAULT_POSX, DEFAULT_POSY, 
                           DEFAULT_WIDTH, DEFAULT_HEIGHT);
  self = [super initWithFrame:rect];
  if (self)
  {
    _background = nil;
    //[self backgroundImage];
  }
  return self;
}

- (id) initForEndCall
{
  self = [self initWithDefaultSize];
  if (self)
  {
    UIImage *buttonBackground = [UIImage imageNamed:@"bottombarred"];
    UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"bottombarred_pressed"];
    UIImage *image = [UIImage imageNamed:@"decline"];
    
    UIButton *endCall = [BottomButtonBar createButtonWithTitle: NSLocalizedString(@"End", @"PhoneView")
                                                         image: image
                                                         frame: CGRectZero
                                                    background: buttonBackground
                                             backgroundPressed: buttonBackgroundPressed];
    [self setButton:endCall];
  }
  return self;
}

- (id) initForIncomingCallWaiting
{
  self = [self initWithDefaultSize];
  if (self)
  {
    UIImage *buttonBackground = [UIImage imageNamed:@"bottombarred"];
    UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"bottombarred_pressed"];
    UIImage *image = [UIImage imageNamed:@"decline"];
    
    UIButton *decline = [BottomButtonBar createButtonWithTitle: NSLocalizedString(@"Decline", @"PhoneView")
                                                         image: image
                                                         frame: CGRectZero
                                                    background: buttonBackground
                                             backgroundPressed: buttonBackgroundPressed];
    [self setButton:decline];
    [decline release];
    
    buttonBackground = [UIImage imageNamed:@"bottombargreen"];
    buttonBackgroundPressed = [UIImage imageNamed:@"bottombargreen_pressed"];
    image = [UIImage imageNamed:@"answer"];
    
    UIButton * answer = [BottomButtonBar createButtonWithTitle: NSLocalizedString(@"Answer", @"PhoneView")
                                                         image: image
                                                         frame: CGRectZero
                                                    background: buttonBackground
                                             backgroundPressed: buttonBackgroundPressed];
    [self setButton2: answer];
    [answer release];
  }
  return self;
}

- (void)dealloc
{
  [_background release];
  [_button  release];
  [_button2 release];
	[super dealloc];
}

- (void)setButton:(UIButton *)newButton
{
  if (newButton == _button)
    return;
  
  [newButton retain];
  CGRect aRect = CGRectMake(kStdButtonPosX, kStdButtonPosY,
                            kDoubleButtonWidth, kStdButtonHeight);
  [newButton setFrame:aRect];
  
  [_button removeFromSuperview];
  [_button release];
  _button = newButton;
  [self addSubview:_button];
}

- (void)setButton2:(UIButton *)newButton
{
  if (newButton == _button2)
    return;
  
  [newButton retain];
  CGRect aRect = CGRectMake(kStdButtonPosX + kDoubleButtonWidth + 20.0, 
                            kStdButtonPosY,
                            kDoubleButtonWidth, kStdButtonHeight);
  [newButton setFrame:aRect];
  
  [_button2 removeFromSuperview];
  [_button2 release];
  _button2 = newButton;
  [self addSubview:_button2];
}

- (void)backgroundImage
{
  if (_background == nil)
  {
#if 1
    UIImage *bg = [BottomButtonBar backgroundImage];
    NSInteger width = bg.size.width;
    bg = [bg stretchableImageWithLeftCapWidth:width/2 topCapHeight:0.0];

    CGRect buttonRect = CGRectMake(0.0, 0.0, 160.0 + 12.0, bg.size.height);
    //buttonRect.size.width = rect.size.width / 2 + 12.0;
    UIGraphicsBeginImageContext(buttonRect.size);
    [bg drawInRect:buttonRect];
    _background = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //[bg release];
#else
    CGImageRef cgImg;

    UIImage *bg = [BottomButtonBar backgroundImage];

    CGRect buttonRect = CGRectMake(0.0, 0.0, 160.0 + 12.0, bg.size.height);
    //buttonRect.size.width = rect.size.width / 2 + 12.0;
    UIGraphicsBeginImageContext(buttonRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect left; left.size = bg.size; left.size.width = left.size.width/2;
    CGRect right = left; right.origin.x = right.size.width + 1;
    CGRect center = CGRectMake(left.size.width , 0.0, 1.0, left.size.height);
    
    // Left
    cgImg = CGImageCreateWithImageInRect([bg CGImage], left);
    CGContextDrawImage(context, left,cgImg);
    CGImageRelease (cgImg);
    // Center
    cgImg = CGImageCreateWithImageInRect([bg CGImage], center);
    center.size.width = buttonRect.size.width - left.size.width * 2;
    CGContextDrawImage(context, center,cgImg);
    CGImageRelease (cgImg);
    // Right
    cgImg = CGImageCreateWithImageInRect([bg CGImage], right);
    right.origin.x = left.size.width + center.size.width;
    CGContextDrawImage(context, right ,cgImg);
    CGImageRelease (cgImg);
    
    _background = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
#endif
  }
}

- (void)drawRect:(CGRect)rect 
{
  CGImageRef cgImg;

  [self backgroundImage];
  
  CGRect buttonRect = rect;
  buttonRect.size.width = rect.size.width / 2;
  
  CGContextRef context = UIGraphicsGetCurrentContext();

  cgImg = CGImageCreateWithImageInRect([_background CGImage], buttonRect);
  CGContextDrawImage(context, buttonRect,cgImg);
  CGImageRelease (cgImg);
  
  buttonRect.origin.x = 12.0;
  cgImg = CGImageCreateWithImageInRect([_background CGImage], buttonRect);
  buttonRect.origin.x = buttonRect.size.width;
  CGContextDrawImage(context, buttonRect,cgImg);
  CGImageRelease (cgImg);
}

@end
