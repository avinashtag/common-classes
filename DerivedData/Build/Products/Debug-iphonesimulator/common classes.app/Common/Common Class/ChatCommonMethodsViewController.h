//
//  ChatCommonMethodsViewController.h
//  PostNChat
//
//  Created by Avinash Tag on 30/11/12.
//  Copyright (c) 2012 Vertax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#define Blog_type_music @"music_song"
#define Blog_type_music_album @"music_album"
#define Blog_type_videos @"video"
#define Blog_type_images @"photo"
#define Blog_type_Blog @"blog"
#define Blog_type_link @"link"


@interface ChatCommonMethodsViewController : UIViewController<UIActionSheetDelegate>
{
    
}
@property (nonatomic,strong)NSMutableArray *arr_PrivacyShare;
@property (nonatomic,strong)    UIActionSheet*    actionSheet;
@property (nonatomic,assign)NSInteger currentPicker_row;

//datasource
@property (nonatomic,strong)NSMutableArray *arr_FriendPrivacy;
@property (nonatomic,strong)NSMutableArray *arr_numbers;
@property (nonatomic,strong)UIDatePicker * datepicker;

@property (nonatomic, strong)MBProgressHUD *progressHud;
@property (nonatomic,strong)NSMutableArray *arr_Relationship;
@property (nonatomic,strong)NSMutableArray *arr_country;
@property (nonatomic,strong)NSMutableArray *arr_smoking;
@property (nonatomic,strong)NSMutableArray *arr_drink;
//setting_profile
@property (nonatomic,strong)NSMutableArray *arr_share_on_wall;
@property (nonatomic,strong)NSMutableArray *arr_View_your_wall;
@property (nonatomic,strong)NSMutableArray *arr_View_your_Followers;
@property (nonatomic,strong)NSMutableArray *arr_Send_you_a_message;
@property (nonatomic,strong)NSMutableArray *arr_View_photos_within_your_profile;
@property (nonatomic,strong)NSMutableArray *arr_Can_send_pokes;
@property (nonatomic,strong)NSMutableArray *arr_View_your_profile;
@property (nonatomic,strong)NSMutableArray *arr_View_your_basic_information;
@property (nonatomic,strong)NSMutableArray *arr_View_your_profile_information;
@property (nonatomic,strong)NSMutableArray *arr_View_your_location;
@property (nonatomic,strong)NSMutableArray *arr_Rate_your_profile;
@property (nonatomic,strong)NSMutableArray *arr_Display_RSS_subscribers_count;
@property (nonatomic,strong)NSMutableArray *arr_Subscribe_to_your_RSS_feed;
@property (nonatomic,strong)NSMutableArray *arr_View_who_recently_viewed_your_profile;
@property (nonatomic,strong)NSMutableArray *arr_DOB;
//settings_items
@property (nonatomic,strong)NSMutableArray *arr_blog;
@property (nonatomic,strong)NSMutableArray *arr_event;
@property (nonatomic,strong)NSMutableArray *arr_marketplace;
@property (nonatomic,strong)NSMutableArray *arr_music;
@property (nonatomic,strong)NSMutableArray *arr_photo;
@property (nonatomic,strong)NSMutableArray *arr_quiz;
@property (nonatomic,strong)NSMutableArray *arr_video;
//settings_notifications
@property (nonatomic, strong)NSMutableArray *arr_new_Comments;
//account_settings
@property (nonatomic, strong)NSMutableArray *arr_time_zone;
@property (nonatomic,strong)NSMutableArray *arr_Planguage;
@property (nonatomic,strong)NSMutableArray *arr_Currency;
@property (nonatomic,strong)NSMutableArray *arr_settings_profile;

@property (nonatomic,strong)NSMutableArray *arr_share_Privacy;
@property (nonatomic,strong)NSMutableArray *arr_followers;
@property (nonatomic,strong)NSMutableArray *arr_followings;
@property (nonatomic,strong)NSMutableArray *arr_market;
@property (nonatomic,strong)NSMutableArray *arr_userGroup;

@property (nonatomic,strong)UIImage *imgPlaceholder;
@property (assign,nonatomic) float KeyboardHeight;

+(ChatCommonMethodsViewController*)shared_Object;

+(BOOL)validateEmail:(NSString *)candidate;

//---------------------------------------------------------------------------------------
//Alert-------------------------
-(void)AlertWithCancel_btn:(NSString*)cancelButtonTitle AlertMessage:(NSString*)AlertMessage ALertTitle:(NSString*)AlertTitle;
-(void)AlertWithError_btn:(NSString*)cancelButtonTitle AlertMessage:(NSString*)AlertMessage ALertTitle:(NSString*)AlertTitle;
-(void)AlertView_Activity_indicator_Stop;
-(void)AlertView_Activity_indicatorTitle:(NSString*)Title Message:(NSString*)Message;
-(void)ALertView_ShareButton;

//---------------------------------------------------------------------------------------
//ActionSheet----------------
- (void)show_ActionSheet:(SEL)EndSelector Datasource:(id)datasource delegate:(id)delegate datasource_array:(NSMutableArray*)array;
-(void)Photo_Video_ActionSheet:(id)delegate;
-(void)Photo_Library:(id)SELF;
-(void)ActionSheetWithOption:(id)delegate CancelButton:(NSString*)cancel OtherButton:(NSArray*)OtherTitle NumberOfButton:(int)no_of_button;
-(void)ActionSheetWithDatePicker :(id)SELF Selector:(SEL)Selector;
-(void)ActionSheet_Dissmiss_With_Aimation;


-(void)Dismiss_ModalViewController:(UINavigationController*) SELF;
-(void)Video_Library:(id)SELF;
-(void)CameraOpen:(id)SELF CaptureImage:(BOOL)ImageCapture CaptureVideo:(BOOL)VideoCapture;


//---------------------------------------------------------------------------------------
//Scroll--------------------------------
-(void)ScrollBack_DownFloat_OR_Y_Position:(float)y scroll:(UIScrollView*)scr;
-(void)ScrollUp_Y_Position:(float)y scroll:(UIScrollView*)scr UpFloatValue:(float)UpValue;
-(void)Scroll_Horizontal:(UIScrollView*)Scroll Page_Position:(int)PagePostion scrollEnableAfterScroll:(BOOL)isScroll;


//Share View
-(void)ShareView_PopIn:(UIView*)View Delegate:(id)delegate;
-(void)ShareView_Out;
-(void)PayPalView_Out;

-(void)MBHUD_Start:(UIView*)parentView;
-(void)MBHUD_Stop;

-(NSString*)DateFormatChanger:(NSString*)date format:(NSString*)format;
-(NSString*)DateFormatChanger_Manchaha:(NSString*)date format_Manchaha:(NSString*)format format_Getting:(NSString*)formatGetting;
+(NSString*)DateFormatRequiredFromDate:(NSDate*)getDate formatRequired:(NSString*)formatRequired;
+(NSDate*)GetDateFromString:(NSString*)DateString format_Getting:(NSString*)format;

+(BOOL)AgeFinder :(NSDate*)BirthDate;
+(NSString*)timeCalculate :(NSString*)Date;

+(BOOL)BlankStringCheck:(NSString*)Text;

-(void)AddHelp:(UIView*)view;
-(UIViewController*)GetViewControllerIfAlreadyinNav:(UINavigationController*)nav compareClass:(NSString*)cls;
//Dialling Number back to app
- (void)dialNumber: (NSString*)telNumber;
-(void)removePaypalView;


+(void)AddSubViewCustom:(UIView*)subview ParentView:(UIView*)ParentView Frame:(CGRect)frame Hide:(BOOL)True;
-(void)AddSelectionPopUp:(UIView*)ParentView DatsourceForTableView:(NSArray*)datasource Delegate:(id)getDeleget ServiceName:(NSInteger)service;

+(NSString*)getCurrentDate;
@end
