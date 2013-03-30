//
//  ChatCommonMethodsViewController.m
//  PostNChat
//
//  Created by Avinash Tag on 30/11/12.
//  Copyright (c) 2012 Vertax. All rights reserved.
//

#import "ChatCommonMethodsViewController.h"
#import "proAlertView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AppDelegate.h"
#import "CommonHeader.h"
#import "SelectPopViewController.h"


@interface ChatCommonMethodsViewController ()
{
    proAlertView *    alertView1;
    NSArray *arr;
    // Hello Avinash Test
}

@end

@implementation ChatCommonMethodsViewController

@synthesize arr_PrivacyShare;
@synthesize actionSheet;
@synthesize currentPicker_row;
@synthesize arr_FriendPrivacy;
@synthesize arr_numbers;
@synthesize datepicker;
@synthesize arr_Relationship;
@synthesize arr_country;
@synthesize arr_smoking;
//settings_profile
@synthesize arr_drink, arr_share_on_wall;
@synthesize arr_View_your_wall;
 @synthesize arr_View_your_Followers;
 @synthesize arr_Send_you_a_message;
 @synthesize arr_View_photos_within_your_profile;
 @synthesize arr_Can_send_pokes;
 @synthesize arr_View_your_profile;
 @synthesize arr_View_your_basic_information;
 @synthesize arr_View_your_profile_information;
 @synthesize arr_View_your_location;
 @synthesize arr_Rate_your_profile;
 @synthesize arr_Display_RSS_subscribers_count;
 @synthesize arr_Subscribe_to_your_RSS_feed;
 @synthesize arr_View_who_recently_viewed_your_profile;
@synthesize arr_DOB;

//settings_edit
@synthesize arr_blog;
@synthesize arr_event;
@synthesize arr_marketplace;
@synthesize arr_music;
@synthesize arr_photo;
@synthesize arr_quiz;
@synthesize arr_video;
//settings_notifications
@synthesize arr_new_Comments;
//account_settings
@synthesize arr_time_zone;
@synthesize arr_Planguage;
@synthesize arr_Currency;
@synthesize arr_settings_profile;

@synthesize arr_followers;
@synthesize arr_followings;

@synthesize arr_market;
@synthesize imgPlaceholder;

@synthesize  arr_userGroup;



ChatCommonMethodsViewController *sharedObject;
UIView *View_Disable_Background;
AppDelegate *appDelegate;


+(ChatCommonMethodsViewController*)shared_Object
{
    if (sharedObject == nil) {
        sharedObject = [[ChatCommonMethodsViewController alloc] initWithNibName:@"" bundle:nil];
        View_Disable_Background = [[UIView alloc] init];
        appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    }
    return sharedObject;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSArray *arr1 = [[NSArray alloc] initWithObjects:@"Public", @"Only Me", @"Friends Of Friends", nil];
        self.arr_FriendPrivacy = [arr1 mutableCopy];
        for (int i = 1; i<=100; i++) {
            [self.arr_numbers addObject:[NSString stringWithFormat:@"%i",i]];
            imgPlaceholder = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"profile.png" ofType:@""]];
        }
        sharedObject = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *dict1= [[NSDictionary alloc] init];
    [dict1 setValue:@"Avinash" forKey:@"Name"];
    NSDictionary *dict2= [[NSDictionary alloc] init];
    [dict1 setValue:@"Deepak" forKey:@"Name"];
    arr= [[NSArray alloc] initWithObjects:dict1,dict2, nil];

      // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Email Validation
+ (BOOL) validateEmail: (NSString *) candidate
{
	NSString *emailRegEx =
	@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
	@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
	@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
	@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
	@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
	@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
	@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
	NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	return [regExPredicate evaluateWithObject:candidate];
}

#pragma mark ALERTVIEW


-(void)AlertView_Activity_indicatorTitle:(NSString*)Title Message:(NSString*)Message
{
	alertView1 = [[proAlertView alloc] initWithTitle:Title message:Message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"background.png" ofType:@""]]] withStrokeColor:[UIColor blackColor]];

    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 75, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [alertView1 addSubview:progress];
    [progress startAnimating];
    [alertView1 show];
}

-(void)AlertView_Activity_indicator_Stop
{
	[alertView1 dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)AlertWithCancel_btn:(NSString*)cancelButtonTitle AlertMessage:(NSString*)AlertMessage ALertTitle:(NSString*)AlertTitle
{
	proAlertView *alertView=[[proAlertView alloc] initWithTitle:AlertTitle message:AlertMessage delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    [alertView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"background.png" ofType:@""]]] withStrokeColor:[UIColor blackColor]];
	[alertView show];
}
-(void)AlertWithError_btn:(NSString*)cancelButtonTitle AlertMessage:(NSString*)AlertMessage ALertTitle:(NSString*)AlertTitle
{
	proAlertView *alertView=[[proAlertView alloc] initWithTitle:AlertTitle message:AlertMessage delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    [alertView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"background.png" ofType:@""]]] withStrokeColor:[UIColor blackColor]];
    [alertView vibrateAlert:0.50];
	[alertView show];
}

-(void)ALertView_ShareButton
{
	alertView1 = [[proAlertView alloc] initWithTitle:nil message:@"\n\n" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"background.png" ofType:@""]]] withStrokeColor:[UIColor blackColor]];
    
    
    UIButton *btnFacebook = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnFacebook setFrame:CGRectMake(40, 35, 68, 62)];
    UIButton *btntwitter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btntwitter setFrame:CGRectMake(175, 35, 68, 62)];
//    UIButton *btnFacebook = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnFacebook setFrame:CGRectMake(40, 35, 68, 62)];

    [alertView1 addSubview:btnFacebook];
    [alertView1 addSubview:btntwitter];
    [alertView1 show];
}

#pragma mark Actionsheet With Picker
- (void)show_ActionSheet:(SEL)EndSelector Datasource:(id)datasource delegate:(id)delegate datasource_array:(NSMutableArray*)array 
{
    if ([arr_PrivacyShare count]>0) {
        [arr_PrivacyShare removeAllObjects];
    }
    arr_PrivacyShare = [array mutableCopy];
    currentPicker_row = 0;
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	actionSheet.delegate=self;
	[actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
	UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
	pickerView.showsSelectionIndicator = YES;
	pickerView.dataSource = datasource;
	pickerView.delegate = delegate;
	[actionSheet addSubview:pickerView];
	
	UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
	closeButton.momentary = YES;
	closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
	closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
	closeButton.tintColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.0];
	[closeButton addTarget:datasource action:EndSelector forControlEvents:UIControlEventValueChanged];
	[actionSheet addSubview:closeButton];
	[actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
	[actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

-(void)Photo_Video_ActionSheet:(id)delegate 
{
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:delegate cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo",@"Videos", nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

-(void)ActionSheetWithOption:(id)delegate CancelButton:(NSString*)cancel OtherButton:(NSArray*)OtherTitle NumberOfButton:(int)no_of_button
{
    switch (no_of_button) {
        case 1:
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:delegate cancelButtonTitle:cancel destructiveButtonTitle:nil otherButtonTitles:[OtherTitle objectAtIndex:0], nil];
            break;
        case 2:
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:delegate cancelButtonTitle:cancel destructiveButtonTitle:nil otherButtonTitles:[OtherTitle objectAtIndex:0],[OtherTitle objectAtIndex:1], nil];
            break;
        case 3:
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:delegate cancelButtonTitle:cancel destructiveButtonTitle:nil otherButtonTitles:[OtherTitle objectAtIndex:0],[OtherTitle objectAtIndex:1],[OtherTitle objectAtIndex:2], nil];
            break;
        case 4:
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:delegate cancelButtonTitle:cancel destructiveButtonTitle:nil otherButtonTitles:[OtherTitle objectAtIndex:0],[OtherTitle objectAtIndex:1],[OtherTitle objectAtIndex:2],[OtherTitle objectAtIndex:3], nil];
            break;
        case 5:
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:delegate cancelButtonTitle:cancel destructiveButtonTitle:nil otherButtonTitles:[OtherTitle objectAtIndex:0],[OtherTitle objectAtIndex:1],[OtherTitle objectAtIndex:2],[OtherTitle objectAtIndex:3],[OtherTitle objectAtIndex:4], nil];
            break;
        default:
            break;
    }
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

-(void)ActionSheetWithDatePicker :(id)SELF Selector:(SEL)Selector {
	
	actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	actionSheet.delegate=self;
	
	datepicker = [[UIDatePicker alloc] init];
	[datepicker setDatePickerMode:UIDatePickerModeDate];
	[actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[actionSheet addSubview:datepicker];
	
	[actionSheet setBounds:CGRectMake(0,0, 320,485)];
	
	CGRect pickerRect = datepicker.bounds;
	pickerRect.origin.y = -40;
	datepicker.bounds = pickerRect;
	//	[actionSheet bringSubviewToFront:picker];
	UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
	closeButton.momentary = YES;
	closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
	closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
	closeButton.tintColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.0];
	[closeButton addTarget:SELF action:Selector forControlEvents:UIControlEventValueChanged];
	[actionSheet addSubview:closeButton];
	[actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
	[actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

-(void)ActionSheet_Dissmiss_With_Aimation
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
	[UIView commitAnimations];
	[actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark Photo & Video Library
-(void)Photo_Library:(id)SELF
{
    UIImagePickerController *imagePicker= [[UIImagePickerController alloc] init];
	imagePicker.delegate = SELF;
	imagePicker.allowsEditing = YES;
    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePicker setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[SELF presentModalViewController:imagePicker animated:YES];
}

-(void)CameraOpen:(id)SELF CaptureImage:(BOOL)ImageCapture CaptureVideo:(BOOL)VideoCapture
{
    NSMutableArray *Capturetype = [[NSMutableArray alloc] init];
    UIImagePickerController *imagePicker= [[UIImagePickerController alloc] init];
	imagePicker.delegate = SELF;
	imagePicker.allowsEditing = YES;
    if (imagePicker) {
        [Capturetype addObject:(NSString*)kUTTypeImage];
    }
    if (VideoCapture) {
        [Capturetype addObject:(NSString*)kUTTypeMovie];
    }
    [imagePicker setMediaTypes:Capturetype];
	imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [imagePicker setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[SELF presentModalViewController:imagePicker animated:YES];
}

-(void)Video_Library:(id)SELF
{
    UIImagePickerController *imagePicker= [[UIImagePickerController alloc] init];
	imagePicker.delegate = SELF;
	imagePicker.allowsEditing = YES;
    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePicker setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[SELF presentModalViewController:imagePicker animated:YES];
}

-(void)Dismiss_ModalViewController:(UINavigationController*) SELF
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Scroll Up/Down
-(void)ScrollBack_DownFloat_OR_Y_Position:(float)y scroll:(UIScrollView*)scr
{
    [scr scrollRectToVisible:CGRectMake(scr.frame.origin.x, y, scr.frame.size.width, scr.frame.size.height) animated:YES];
}
-(void)ScrollUp_Y_Position:(float)y scroll:(UIScrollView*)scr UpFloatValue:(float)UpValue
{
    [scr scrollRectToVisible:CGRectMake(scr.frame.origin.x, y+UpValue, scr.frame.size.width, scr.frame.size.height) animated:YES];
}

-(void)Scroll_Horizontal:(UIScrollView*)Scroll Page_Position:(int)PagePostion scrollEnableAfterScroll:(BOOL)isScroll
{
    [Scroll setScrollEnabled:YES];
    [Scroll scrollRectToVisible:CGRectMake(Scroll.frame.size.width*PagePostion, Scroll.frame.origin.y, Scroll.frame.size.width, Scroll.frame.size.height) animated:YES];
    [Scroll setScrollEnabled:isScroll];
}





#pragma mark MB HUD

-(void)MBHUD_Start:(UIView*)parentView
{
    
    UIView* parentView1 = [appDelegate window];
    _progressHud = [MBProgressHUD showHUDAddedTo:parentView1 animated:YES];
    _progressHud.dimBackground = YES;
    _progressHud.removeFromSuperViewOnHide = YES;
    _progressHud.labelText = AppName;
    _progressHud.detailsLabelText = @"Please wait";
    _progressHud.square = YES;
}

-(void)MBHUD_Stop
{
    if (_progressHud !=nil)
        [_progressHud hide:YES];
    _progressHud = nil;
}

#pragma mark Date Method

-(NSString*)DateFormatChanger:(NSString*)date format:(NSString*)format
{
    NSString *str;
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMddyyyy"];
    NSDate *dOB = [dateformatter dateFromString:date];
    
    [dateformatter setDateFormat:format];
    str = [dateformatter stringFromDate:dOB ];
    return str;
}



-(NSString*)DateFormatChanger_Manchaha:(NSString*)date format_Manchaha:(NSString*)format format_Getting:(NSString*)formatGetting
{
    NSString *str;
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:formatGetting];

    NSDate *dOB = [dateformatter dateFromString:date];
    [dateformatter setDateFormat:format];
    str = [dateformatter stringFromDate:dOB ];
    return str;
}

+(NSString*)DateFormatRequiredFromDate:(NSDate*)getDate formatRequired:(NSString*)formatRequired
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:formatRequired];
    NSString * DateString = [dateformatter stringFromDate:getDate ];
    return DateString;
}

+(BOOL)AgeFinder :(NSDate*)BirthDate
{
    BOOL isAdult;
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:BirthDate
                                       toDate:now
                                       options:0];
    if ([ageComponents year]>=18) {
        isAdult = YES;
    }
   else
   {
       isAdult = NO;
   }
    return isAdult;
    
    
}

+(NSString*)timeCalculate :(NSString*)Date
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
     [dateformatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    
    NSDate* date = [dateformatter dateFromString:Date];
    NSString* isAdult;
    NSDate* now = [NSDate date];
    NSDateComponents* yearComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:date
                                       toDate:now
                                       options:0];
    NSDateComponents* monthComponents = [[NSCalendar currentCalendar]
                                       components:kCFCalendarUnitMonth
                                       fromDate:date
                                       toDate:now
                                       options:0];

    NSDateComponents* dayComponents = [[NSCalendar currentCalendar]
                                       components:kCFCalendarUnitDay
                                       fromDate:date
                                       toDate:now
                                       options:0];
    NSDateComponents* hourComponents = [[NSCalendar currentCalendar]
                                       components:kCFCalendarUnitHour
                                       fromDate:date
                                       toDate:now
                                       options:0];
    NSDateComponents* minuteComponents = [[NSCalendar currentCalendar]
                                       components:kCFCalendarUnitMinute
                                       fromDate:date
                                       toDate:now
                                       options:0];
    NSDateComponents* secondComponents = [[NSCalendar currentCalendar]
                                       components:kCFCalendarUnitSecond
                                       fromDate:date
                                       toDate:now
                                       options:0];

    if ([secondComponents second]<60) {
        isAdult = [NSString stringWithFormat:@"%i seconds ago", [secondComponents second]];
    }
    else if ([minuteComponents minute]<60) {
        isAdult = [NSString stringWithFormat:@"%i minutes ago", [minuteComponents minute]];
    }
    else if ([hourComponents hour]<24) {
        isAdult = [NSString stringWithFormat:@"%i hour ago", [hourComponents hour]];
    }
    else if ([dayComponents day]<=30) {
        isAdult = [NSString stringWithFormat:@"%i Day Ago", [dayComponents day]];
    }
    else if ([monthComponents month]<=12) {
        isAdult = [NSString stringWithFormat:@"%i Month Ago", [monthComponents month]];
    }
    else  {
        isAdult = [NSString stringWithFormat:@"%i Year Ago", [yearComponents year]];
    }
       return isAdult;
  }

-(id)Fbshare{
    id t;
    return t;
}
-(id)TwitterShare{
    id t;
    return t;
}

+(BOOL)BlankStringCheck:(NSString*)Text
{
    BOOL Result = [[Text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]?YES:NO;
    return Result;
}

- (void)someMethodWhereYouSetUpYourObserver
{
    // This could be in an init method.
}



- (void)dialNumber: (NSString*)telNumber
{
    // fix telNumber NSString
    NSArray* telComponents = [telNumber componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    telNumber = [telComponents componentsJoinedByString: @""];
    
    NSString* urlString = [NSString stringWithFormat: @"telprompt:%@", telNumber];
    NSURL* telURL = [NSURL URLWithString: urlString];
    //NSLog( @"Attempting to dial %@ with urlString: %@ and URL: %@", telNumber, urlString, telURL );
    
    if ( [[UIApplication sharedApplication] canOpenURL: telURL] )
    {
        [[UIApplication sharedApplication] openURL: telURL];
    }
    else
    {
        
        [[ChatCommonMethodsViewController shared_Object] AlertWithCancel_btn:@"Ok" AlertMessage:@"There was a problem dialing the number" ALertTitle:AppName];
    }
}
-(UIViewController*)GetViewControllerIfAlreadyinNav:(UINavigationController*)nav compareClass:(NSString*)cls
{
    UIViewController *Object;
    NSArray *arrSearchIn = [nav viewControllers];
    for (UIViewController *ctr in arrSearchIn)
    {
        if ([ctr isKindOfClass:NSClassFromString(cls)])
        {
            Object = ctr;
            break;
        }
    }
    return Object;
}

+(void)AddSubViewCustom:(UIView*)subview ParentView:(UIView*)ParentView Frame:(CGRect)frame Hide:(BOOL)True
{
    [subview setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [ParentView addSubview:subview];
    [subview setHidden:TRUE];
}


-(void)AddSelectionPopUp:(UIView*)ParentView DatsourceForTableView:(NSArray*)datasource Delegate:(id)getDeleget ServiceName:(NSInteger)service
{
    SelectPopViewController *selectedPop = [[SelectPopViewController alloc]initWithNibName:@"SelectPopViewController" bundle:nil];
    selectedPop.popDelegate = getDeleget;
    selectedPop.Servicename = service;
    CGRect rectpop = CGRectMake(ParentView.frame.origin.x, ParentView.frame.origin.y- 20, ParentView.frame.size.width, ParentView.frame.size.height);
    [ChatCommonMethodsViewController AddSubViewCustom:selectedPop.view ParentView:ParentView Frame:rectpop Hide:YES];
    [selectedPop.view popIn:0.30 delegate:nil];
    
}

+(NSString*)getCurrentDate
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"ddMMyyyyHHmmss"];
    NSString *strReturn = [dateformatter stringFromDate:today];
    return strReturn;
}
+(NSDate*)GetDateFromString:(NSString*)DateString format_Getting:(NSString*)format
{
    NSDate*Datereturn;
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format];
    Datereturn = [dateformatter dateFromString:DateString];
    return Datereturn;
}
@end
