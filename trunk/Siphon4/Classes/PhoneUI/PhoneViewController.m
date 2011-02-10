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

#import "PhoneViewController.h"
#import "SiphonAppDelegate.h"

#import "UIScreen+ConvertRect.h"

#import "SIPController.h"
#import "SIPAccountController.h"

#import "AKSIPURI.h"

static const NSString *forbiddenChars = @",;/?:&=+$";

@interface PhoneViewController ()

- (void)addNewPerson;

#if defined(POPOVER_CALL) && POPOVER_CALL!=0
@property (nonatomic, retain) CallPickerController *callPicker;
@property (nonatomic, retain) WEPopoverController  *callPickerPopover;
#endif /* POPOVER_CALL */

@end

@implementation PhoneViewController

#if defined(POPOVER_CALL) && POPOVER_CALL!=0
@synthesize callPicker = _callPicker;
@synthesize callPickerPopover = _callPickerPopover;
#endif /* POPOVER_CALL */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) 
  {
		// Initialization code
    self.title = NSLocalizedString(@"Keypad", @"Keypad to dial");
    self.tabBarItem.image = [UIImage imageNamed:@"Dial"];
    
    _lcd = [[LCDPhoneView alloc] initWithFrame:
            CGRectMake(0.0f, 0.0f, 320.0f, 74.0f)];
    _lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top_buttons"]];
    //_lcd.backgroundColor = [UIColor clearColor];
    
    [_lcd leftText: [[NSUserDefaults standardUserDefaults] stringForKey: 
                     @"server"]];
    [_lcd rightText:NSLocalizedString(@"Disconnected", 
																			@"Initialize with disconnected status because here we don't know the status.")];

#if 0
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(processRegState:)
                                                 name: kSIPRegState 
                                               object:nil];
#endif
		
    peoplePickerCtrl = [[ABPeoplePickerNavigationController alloc] init];
    peoplePickerCtrl.navigationBar.barStyle = UIBarStyleBlackOpaque;
    peoplePickerCtrl.peoplePickerDelegate = self;
	}
	return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
*/
- (void)loadView 
{  
  UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
  [view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
//  //[view setBackgroundColor:_color];
  
  _textfield = [[UITextField alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 74.0f)];
  //_textField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
  _textfield.autocorrectionType = UITextAutocorrectionTypeNo;
  _textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
  _textfield.keyboardType = UIKeyboardTypeURL;
  _textfield.returnKeyType = UIReturnKeyDone;
  _textfield.borderStyle = UITextBorderStyleNone;
  _textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  _textfield.delegate = self;
  _textfield.textColor = [UIColor lightGrayColor];
  _textfield.backgroundColor = [UIColor clearColor];
  _textfield.font = [UIFont fontWithName:@"Helvetica" size:35];
  _textfield.minimumFontSize = 15;
  _textfield.adjustsFontSizeToFitWidth = YES;
  _textfield.textAlignment = UITextAlignmentCenter;
  _textfield.text = @"";
  [_lcd addSubview:_textfield];
  
  _pad = [[DialerPhonePad alloc] initWithFrame: 
          CGRectMake(0.0f, 74.0f, 320.0f, 273.0f)];

  [_pad setPlaysSounds:YES];
  /*[_pad setPlaysSounds:[[NSUserDefaults standardUserDefaults] 
                        boolForKey:@"keypadPlaySound"]];*/
  [_pad setDelegate:self];
  
	_addContactButton = [[UIButton alloc] initWithFrame:
                         CGRectMake(0.0f, 0.0f, 107.0f, 64.0f)];
	[_addContactButton setImage: [UIImage imageNamed:@"addcontact"]
                       forState:UIControlStateNormal];
	[_addContactButton setImage: [UIImage imageNamed:@"addcontact_pressed"] 
                       forState:UIControlStateHighlighted];
	[_addContactButton addTarget:self action:@selector(addButtonPressed:) 
                       forControlEvents:UIControlEventTouchDown];

#if GSM_BUTTON
    _gsmCallButton =[[UIButton alloc] initWithFrame:
                     CGRectMake(0.0f, 0.0f, 107.0f, 64.0f)];
    [_gsmCallButton setImage:[UIImage imageNamed:@"answer"] 
                 forState: UIControlStateNormal];
    _gsmCallButton.imageEdgeInsets = UIEdgeInsetsMake (0., 0., 0., 5.);
    [_gsmCallButton setTitle:@"GSM" forState:UIControlStateNormal];
#ifdef __IPHONE_3_0
    _gsmCallButton.titleLabel.shadowOffset = CGSizeMake(0,-1);
    _gsmCallButton.titleLabel.font = [UIFont boldSystemFontOfSize:26];
#else
    _gsmCallButton.titleShadowOffset = CGSizeMake(0,-1);
    _gsmCallButton.font = [UIFont boldSystemFontOfSize:26];
#endif
    [_gsmCallButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_gsmCallButton setTitleShadowColor:[UIColor colorWithWhite:0. alpha:0.2]  forState:UIControlStateDisabled];
    [_gsmCallButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_gsmCallButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5]  forState:UIControlStateDisabled];

    _gsmCallButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"callblue"]];
    
    [_gsmCallButton addTarget:self action:@selector(gsmCallButtonPressed:) 
          forControlEvents:UIControlEventTouchDown];
#endif /* GSM_BUTTON */
	
  _callButton =[[UIButton alloc] initWithFrame:
                CGRectMake(107.0f, 0.0f, 107.0f, 64.0f)];
	_callButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"call"]];
  //_callButton.enabled = NO;

  [_callButton setImage:[UIImage imageNamed:@"answer"] 
               forState: UIControlStateNormal];
  _callButton.imageEdgeInsets = UIEdgeInsetsMake (0., 0., 0., 5.);
  [_callButton setTitle:@"Call" forState:UIControlStateNormal];
#if __IPHONE_3_0
  _callButton.titleLabel.shadowOffset = CGSizeMake(0,-1);
  _callButton.titleLabel.font = [UIFont boldSystemFontOfSize:26];
#else
  _callButton.titleShadowOffset = CGSizeMake(0,-1);
  _callButton.font = [UIFont boldSystemFontOfSize:26];
#endif
  [_callButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [_callButton setTitleShadowColor:[UIColor colorWithWhite:0. alpha:0.2]  forState:UIControlStateDisabled];
  [_callButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
  [_callButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5]  forState:UIControlStateDisabled];

	[_callButton addTarget:self action:@selector(callButtonDidPress:) 
				forControlEvents:UIControlEventTouchDown];
	[_callButton addTarget:self action:@selector(callButtonDidReleaseOutside:) 
				forControlEvents:UIControlEventTouchUpOutside];

  [_callButton addTarget:self action:@selector(callButtonDidReleaseInside:) 
               forControlEvents:UIControlEventTouchUpInside];
  
  _deleteButton = [[UIButton alloc] initWithFrame:
                   CGRectMake(214.0f, 0.0f, 107.0f, 64.0f)];
  [_deleteButton setImage:[UIImage imageNamed:@"delete"] 
                 forState:UIControlStateNormal];
  [_deleteButton setImage: [UIImage imageNamed:@"delete_pressed"] 
                 forState:UIControlStateHighlighted];
  [_deleteButton addTarget:self action:@selector(deleteButtonPressed:) 
                 forControlEvents:UIControlEventTouchDown];
  [_deleteButton addTarget:self action:@selector(deleteButtonReleased:) 
                 forControlEvents:UIControlEventValueChanged| 
                 UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
	
  _container = [[UIView alloc] initWithFrame:
                CGRectMake(0.0f, 347.0f, 320.0f, 64.0f)];
  
	[view addSubview:_lcd];
  [view addSubview:_pad];

	[_container addSubview:_addContactButton];
#if GSM_BUTTON
	[_container addSubview:_gsmCallButton];
#endif /* GSM_BUTTON */
  [_container addSubview:_callButton];
  [_container addSubview:_deleteButton];
  
  [view addSubview:_container];

  self.view = view;
  [view release];
}

/*
 If you need to do additional setup after loading the view, override viewDidLoad
 */
- (void)viewDidLoad 
{
  [super viewDidLoad];
  _callButton.enabled = NO;
#if GSM_BUTTON
  if (_gsmCallButton)
    _gsmCallButton.enabled = NO;
#endif /* GSM_BUTTON */
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{ 
  _pad.enabled = NO;
  
#if GSM_BUTTON
  if (_gsmCallButton)
    _gsmCallButton.enabled = NO;
#endif /* GSM_BUTTON */
	
  _lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
  
  NSDictionary* info = [aNotification userInfo];
  
  // Get the size of the keyboard.
	NSValue* aValue = [info valueForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect keyboardEndFrame = [UIScreen convertRect:[aValue CGRectValue] 
																					 toView:self.view];

	CGRect rect = _container.frame;
	rect.origin.y = keyboardEndFrame.origin.y - 64.0f;
#if 0
	[UIView beginAnimations:@"scroll" context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:0.3];
	[_container setFrame:rect];
	[UIView commitAnimations];
#else
	[UIView animateWithDuration:0.3
									 animations:^{
										 _container.frame = rect;
									 }];
#endif
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
  //[_scrollView setContentOffset:CGPointZero animated:YES];
  _lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top_buttons"]];
  
	CGRect rect = _container.frame;
  rect.origin.y = 347.0f;
	
#if 0
	[UIView beginAnimations:@"scroll" context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:0.3];
  [_container setFrame:rect];
  [UIView commitAnimations];
	
  _pad.enabled = YES;
#else
	[UIView animateWithDuration:0.3
									 animations:^{
										 _container.frame = rect;
									 } 
									 completion:^(BOOL finished){
										 _pad.enabled = YES;
									 }];
#endif
}

- (void)viewWillAppear:(BOOL)animated 
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification 
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated 
{
  [_textfield resignFirstResponder];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillShowNotification 
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillHideNotification 
                                                object:nil];
#if defined(POPOVER_CALL) && POPOVER_CALL!=0
	if ([self.callPickerPopover isPopoverVisible])
	{
		[self.callPickerPopover dismissPopoverAnimated:NO];
	}
#endif /* POPOVER_CALL */
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc 
{
#if 0
  [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                  name: kSIPRegState 
                                                object:nil];
#endif
  [peoplePickerCtrl release];

  [_textfield release];
  [_lcd release];
  [_pad release];

  [_addContactButton release];
#if GSM_BUTTON
  [_gsmCallButton release];
#endif /* GSM_BUTTON */
#if defined(POPOVER_CALL) && POPOVER_CALL!=0
	[_callButtonTimer invalidate];
	[_callButtonTimer release];
	
	[_callPickerPopover release];
#endif /* POPOVER_CALL */
  [_callButton release];

	[_deleteTimer invalidate];
	[_deleteTimer release];
  [_deleteButton release];


  [_container release];

  //NSTimer *_deleteTimer;
  //NSString *_lastNumber;
  
	[super dealloc];
}

/*** Buttons callback ***/
- (void)phonePad:(id)phonepad appendString:(NSString *)string
{
  NSString *curText = [_textfield text];
  [_textfield setText: [curText stringByAppendingString: string]];
  
  _callButton.enabled = YES;
#if GSM_BUTTON
  if (_gsmCallButton)
    _gsmCallButton.enabled = YES;
#endif /* GSM_BUTTON */
  _lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
}
- (void)phonePad:(id)phonepad replaceLastDigitWithString:(NSString *)string
{
  NSString *curText = [_textfield text];
  curText = [curText substringToIndex:([curText length] - 1)];
  [_textfield setText: [curText stringByAppendingString: string]];
}

#if defined(POPOVER_CALL) && POPOVER_CALL!=0
- (void)callButtonDidLongPress:(NSTimer *)timer
{
	//UIButton *button = [timer userInfo];
	
	if (_callPickerPopover == nil)
	{
		self.callPicker = [[CallPickerController alloc] initWithStyle:UITableViewStylePlain];
		self.callPickerPopover = [[WEPopoverController alloc]
															initWithContentViewController:self.callPicker];
		//CGRect rect = _callButton.frame;
		//rect = _container.frame;
	}
	[self.callPickerPopover presentPopoverFromRect:_container.frame/*(CGRect)rect*/
																					inView:self.view /*self.view/*button*/ 
												permittedArrowDirections:UIPopoverArrowDirectionDown 
																				animated:YES];
}

- (void)callButtonDidPress:(UIButton *)button
{
	if ([[_textfield text] length] > 0)
		_callButtonTimer = [[NSTimer scheduledTimerWithTimeInterval:0.5 target:self 
																											 selector:@selector(callButtonDidLongPress:) 
																											 userInfo:button 
																												repeats:NO] retain];
	else 
		_callButtonTimer = nil;
}

- (void)callButtonDidReleaseOutside:(UIButton *)button
{
	[_callButtonTimer invalidate];
	[_callButtonTimer release];
	_callButtonTimer = nil;
}
#endif /* POPOVER_CALL */

- (void)callButtonDidReleaseInside:(UIButton*)button
{
#if defined(POPOVER_CALL) && POPOVER_CALL!=0
	if (![self.callPickerPopover isPopoverVisible])
	{
		[_callButtonTimer invalidate];
		[_callButtonTimer release];
		_callButtonTimer = nil;
#endif /* POPOVER_CALL */
	
	if ([[_textfield text] length] > 0)
	{
		_lastNumber = [[NSString alloc] initWithString: [_textfield text]];
    [_textfield setText:@""];
		_lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top_buttons"]];
		
		AccountController *firstEnabledAccountController = [[[SIPController sharedInstance] 
																												 enabledAccountControllers] objectAtIndex:0];
		
		AKSIPURI *destinationURI = [AKSIPURI SIPURIWithUser:_lastNumber
																									 host:firstEnabledAccountController.account.registrar
																						displayName:_lastNumber /*[dictionnary valueForKey:@"name"]*/];
		
		[firstEnabledAccountController makeCallToURI:destinationURI
																			phoneLabel:nil/*[dictionnary valueForKey:@"label"]*/];
		
	}
	else
  {
    _lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
    [_textfield setText:_lastNumber];
    [_lastNumber release];
  }
#if defined(POPOVER_CALL) && POPOVER_CALL!=0
	}
#endif /* POPOVER_CALL */
}

- (void)addButtonPressed:(UIButton*)unused
{
  if ([[_textfield text] length] < 1) 
    return;

  if (ABAddressBookGetPersonCount(ABAddressBookCreate ()) == 0)
  {
    // Create a new contact
    [self addNewPerson];
  }
  else
  {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                  delegate:self 
                                  cancelButtonTitle:NSLocalizedString(@"Cancel",@"Phone View") 
                                  destructiveButtonTitle:nil 
                                  otherButtonTitles:NSLocalizedString(@"Create New Contact",@"Phone View"),
                                  NSLocalizedString(@"Add to Existing Contact",@"Phone View"), nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;

		SiphonAppDelegate *appDelegate = (SiphonAppDelegate *)[[UIApplication sharedApplication] delegate];
		[actionSheet showFromTabBar:appDelegate.tabBarController.tabBar];
  }
}

#if GSM_BUTTON
- (void)gsmCallButtonPressed:(UIButton*)button
{
  NSURL *url;
  NSString *urlStr;
  if ([[_textfield text] length] > 0)
  {
    urlStr = [NSString stringWithFormat:@"tel://%@",[_textfield text],nil];
    url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL: url]; 
    //_lastNumber = [NSString stringWithString: [_textfield text]];
    //[_textfield setText:@""];
  }
  else
  {
    _lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
    [_textfield setText:_lastNumber];
    [_lastNumber release];
  }
}
#endif /* GSM_BUTTON */

- (void)stopTimer
{
  if (_deleteTimer)
  {
    [_deleteTimer invalidate];
    [_deleteTimer release];
    _deleteTimer = nil;
  }
  if ([[_textfield text] length] == 0)
  {
    _callButton.enabled = NO;
#if GSM_BUTTON
    if (_gsmCallButton)
      _gsmCallButton.enabled = NO;
#endif /* GSM_BUTTON */
    if (!_textfield.editing)
      _lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top_buttons"]];
  }
}

- (void)deleteRepeat
{
  NSString *curText = [_textfield text];
  int length = [curText length];
  if(length > 0)
  {
    _deletedChar++;
    if (_deletedChar == 6)
    {
      [_textfield setText:@""];
    }
    else
    {
      [_textfield setText: [curText substringToIndex:(length-1)]];
    }
  }
  else
  {
    [self stopTimer];
  }
}

- (void)deleteButtonPressed:(UIButton*)unused
{
  _deletedChar = 0;
  [self deleteRepeat];
  _deleteTimer = [[NSTimer scheduledTimerWithTimeInterval:0.2 target:self 
                                                selector:@selector(deleteRepeat) 
                                                userInfo:nil 
                                                repeats:YES] retain];
}

- (void)deleteButtonReleased:(UIButton*)unused
{
  [self stopTimer];
}

- (void)addNewPerson
{
  CFErrorRef error = NULL;
  // Create New Contact
  ABRecordRef person = ABPersonCreate ();
  
  // Add phone number
  ABMutableMultiValueRef multiValue = 
  ABMultiValueCreateMutable(kABStringPropertyType);
  
  ABMultiValueAddValueAndLabel(multiValue, [_textfield text], kABPersonPhoneMainLabel, 
                               NULL);  
  
  ABRecordSetValue(person, kABPersonPhoneProperty, multiValue, &error);
  
  
  ABNewPersonViewController *newPersonCtrl = [[ABNewPersonViewController alloc] init];
  newPersonCtrl.newPersonViewDelegate = self;
  newPersonCtrl.displayedPerson = person;
  CFRelease(person); // TODO check
  
  UINavigationController *navCtrl = [[UINavigationController alloc] 
                                     initWithRootViewController:newPersonCtrl];
  navCtrl.navigationBar.barStyle = UIBarStyleBlackOpaque;
  [self.parentViewController presentModalViewController:navCtrl animated:YES];
  [newPersonCtrl release];
  [navCtrl release];
}

#pragma mark -
#pragma mark ABNewPersonViewControllerDelegate
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController 
       didCompleteWithNewPerson:(ABRecordRef)person
{
  [newPersonViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark ABPeoplePickerNavigationControllerDelegate
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
  CFErrorRef error = NULL;
  BOOL status;
  ABMutableMultiValueRef multiValue;
  // Inserer le numéro dans la fiche de la personne
  // Add phone number
  CFTypeRef typeRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
  if (ABMultiValueGetCount(typeRef) == 0)
    multiValue = ABMultiValueCreateMutable(kABStringPropertyType);
  else
    multiValue = ABMultiValueCreateMutableCopy (typeRef);
  
  // TODO type (mobile, main...)
  // TODO manage URI
  status = ABMultiValueAddValueAndLabel(multiValue, [_textfield text], kABPersonPhoneMainLabel, 
                               NULL);  
  
  status = ABRecordSetValue(person, kABPersonPhoneProperty, multiValue, &error);
  status = ABAddressBookSave(peoplePicker.addressBook, &error);
  [peoplePicker dismissModalViewControllerAnimated:YES];
  return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person 
                                property:(ABPropertyID)property 
                              identifier:(ABMultiValueIdentifier)identifier
{
  return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
  [peoplePicker dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet 
                    clickedButtonAtIndex:(NSInteger)buttonIndex
{
  switch (buttonIndex) 
  {
    case 0: // Create new contact
      [self addNewPerson];
      break;
    case 1: // Add to existing Contact
      [self presentModalViewController:peoplePickerCtrl animated:YES];
			break;
    default:
      break;
  }
}

#if 0
- (void)cancelAddPerson:(id)unused
{
  [self.parentViewController dismissModalViewControllerAnimated:YES];
}
#endif

- (void)reachabilityChanged:(NSNotification *)notification
{
  [_lcd rightText:@"Service Unavailable"];
}

#if 0
- (void)processRegState:(NSNotification *)notification
{
  //pjsua_acc_info info;
  //pjsua_acc_id acc_id;
  //NSString *status;
  //acc_id = [[[ notification userInfo ] objectForKey: @"AccountID"] intValue];
  NSDictionary *dictionary = [notification userInfo];
  if ([[dictionary objectForKey:@"Status"] intValue] == 200)
    [_lcd rightText:@"Connected"];
  else
    [_lcd rightText:[dictionary objectForKey:@"StatusText"]];
}
#endif

#pragma mark -
#pragma mark TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  [_textfield setText:@""];
  _callButton.enabled = NO;
  return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  NSRange r = [forbiddenChars rangeOfString: string];
  if (r.location != NSNotFound)
    return NO;
  
  _callButton.enabled = ([[textField text] length] + [string length] - range.length > 0);
  
  return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  return ([[textField text] length] == 0);
}

@end
