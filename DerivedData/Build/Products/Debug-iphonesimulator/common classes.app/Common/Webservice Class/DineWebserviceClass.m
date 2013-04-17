//
//  DineWebserviceClass.m
//  DineForDime
//
//  Created by Vertax on 18/02/13.
//  Copyright (c) 2013 Vertax. All rights reserved.
//

#import "DineWebserviceClass.h"
#import "SBJSON.h"
#import "GlobalWebservice.h"
#import "DineWebserviceSwitch.h"
#import "ChatCommonMethodsViewController.h"
#import "Constants.h"

@implementation DineWebserviceClass
@synthesize delegate;
@synthesize user_id;
@synthesize couponCode;
@synthesize isFacebookLogin;
@synthesize pack_id;

static DineWebserviceClass* Object_Shared = Nil;
NSMutableData *Body ;
NSMutableData *PostDataBody;
+(DineWebserviceClass*)SharedObject
{
    @synchronized([DineWebserviceClass class])
    {
        if (!Object_Shared)
            Object_Shared = [[self alloc] init];
        return Object_Shared;
    }
    return nil;
}

#pragma mark Webservice Call
-(void)Webservice:(NSString*)UrlString SelfViewForActivityIndicator:(UIView*)View
{
    
    //    [[ChatCommonMethodsViewController shared_Object]AlertView_Activity_indicatorTitle:AppName Message:@"Please Wait.."];
    [[ChatCommonMethodsViewController shared_Object] MBHUD_Start:nil];
    [self performSelectorInBackground:@selector(makeRequest_GetMethod:) withObject:UrlString];
}

- (void)makeRequest_GetMethod:(NSString*)url_String
{
    
    @autoreleasepool
    {
        NSArray *data_Object = [GlobalWebservice ExecuteWebService:url_String];
    }
}

-(void)delegateCall:(id)data
{
    [[ChatCommonMethodsViewController shared_Object]MBHUD_Stop];
    if ([data isKindOfClass:NSClassFromString(@"NSArray")])
    {
        [self.delegate WebServiceLoadData:data Message:@""];
    }
    else if ([data isKindOfClass:NSClassFromString(@"NSString")])
    {
        [self performSelectorOnMainThread:@selector(mainThreadAlertSuccess:) withObject:data waitUntilDone:YES];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(mainThreadAlertSuccess:) withObject:@"Inavlid Data Format" waitUntilDone:YES];
    }

}

-(void)Registration_Name:(NSString*)Name Username:(NSString*)username Password:(NSString*)password EmailAddress:(NSString*)EmailAddress selfView:(UIView*)view
{
//    type=web_service&name=aaa&username=aaaa&password=qq&email=sasa@aa.aa
    _WebService_Identifier = Webservice_Registration;

       NSString *strurl = [NSString stringWithFormat:@"registration.php?name=%@&username=%@&email=%@&password=%@&type=web_service",Name,username, EmailAddress, password];
        [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)Login:(NSString*)Username Password:(NSString*)password selfView:(UIView*)view Delegate:(id)Delegate
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_Login;
    NSString *strurl = [NSString stringWithFormat:@"login.php?user_name=%@&password=%@" ,Username, password];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)Forgot_Password:(NSString*)email_address selfView:(UIView*)view
{
//    NSString *strurl = [NSString stringWithFormat:@"login.php?user_name=%@&password=%@" ,Username, password];
//    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)Feedback_name:(NSString*)name Email:(NSString*)email_address comment:(NSString*)comment selfView:(UIView*)view
{
    _WebService_Identifier = Webservice_Feedback;
     NSString *strurl = [NSString stringWithFormat:@"feedback.php?name=%@&email=%@&comment=%@" ,name, email_address, comment];
        [self Webservice:strurl SelfViewForActivityIndicator:view];
}


-(void)VoucherList:(UIView*)View  Delegate:(id)Delegate Category :(NSInteger)category
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_VoucherList;
    NSString *strurl = [NSString stringWithFormat:@"voucher_list.php?category=%d",category];
    [self Webservice:strurl SelfViewForActivityIndicator:View];
}


-(void)HomeList:(UIView*)view Delegate:(id)Delegate
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_HomeList;
    NSString *strurl = [NSString stringWithFormat:@"category_list.php"];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)AddTofavourites:(UIView*)view Delegate:(id)Delegate Coupon_id:(NSString*)Coupon_id UserId :(NSString*)UserID
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_AddToFavourites;
    NSString *strurl = [NSString stringWithFormat:@"add_to_favorite.php?coupon_id=%@&user_id=%@",Coupon_id, UserID];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)Myfavourites:(UIView*)view Delegate:(id)Delegate UserId :(NSString*)UserID
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_VoucherList;
    NSString *strurl = [NSString stringWithFormat:@"favorite_list.php?user_id=%@", UserID];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)MyVoucherList:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)Userid
{
     self.delegate=Delegate;
    _WebService_Identifier = Webservice_MyVoucherList;
    NSString *strurl = [NSString stringWithFormat:@"my_vouchers.php?user_id=%@",Userid];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)PrintCoupon:(UIView*)view Delegate:(id)Delegate CouponId:(NSString*)couponId UserId:(NSString*)Userid
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_CheckValid;
    NSString *strurl = [NSString stringWithFormat:@"print_coupon.php?coupon_id=%@&u_id=%@",couponId,Userid];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}


-(void)Rate:(UIView*)view Delegae:(id)Delegate Coupon_id:(NSString*)coupon_id User_id:(NSString*)User_id rate_atmosphere:(NSString*)rate_atmosphere rate_food:(NSString*)rate_food rate_service:(NSString*)rate_service rate_location:(NSString*)rate_location comment:(NSString*)comment
{
    
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_Rate;
    NSString *strurl = [NSString stringWithFormat:@"rating.php?coupon_id=%@&user_id=%@&rating_atmosphere=%@&rating_food=%@&rating_service=%@&rating_location=%@&comment=%@",coupon_id, User_id, rate_atmosphere, rate_food, rate_service, rate_location, comment];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}
-(void)ExpiredVouchers:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)Userid
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_ExpiredVoucher;
    NSString *strurl = [NSString stringWithFormat:@"expired_vouchers.php?user_id=%@",Userid];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)ExistingCoupons:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)Userid
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_ExistingCoupon;
    NSString *strurl = [NSString stringWithFormat:@"existing_coupons.php?user_id=%@",Userid];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)ExistingVoucher:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)Userid
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_ExistingVoucher;
    NSString *strurl = [NSString stringWithFormat:@"existing_vouchers.php?user_id=%@",Userid];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)Redeem:(UIView*)view Delegate:(id)Delegate Coupon_Id:(NSString*)coupon_id
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_Redeem;
    NSString *strurl = [NSString stringWithFormat:@"coupon_code.php?coupon_id=%@",coupon_id];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)PostImage:(NSMutableData*)Body userId:(NSString*)userId email:(NSString*)email Delegate:(id)Delegate
{
    self.delegate = Delegate;
    _WebService_Identifier = Webservice_Login;    
    [Body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[Body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"LoginRadius_id\"\r\n\r\n%@",userId] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [Body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[Body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"provider\"\r\n\r\n%@",@"facebook"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [Body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[Body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n%@",email] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableDictionary *PostData = [[NSMutableDictionary alloc] init];
    NSString *strurl = [NSString stringWithFormat:@"%@facebooklogin.php",MainUrl];
    [PostData setValue:strurl forKey:@"URL"];
    //   [PostData setValue:@"android.php" forKey:@"URL"];
    [PostData setValue:Body forKey:@"BODY"];
    [[ChatCommonMethodsViewController shared_Object] MBHUD_Start:nil];
    [self performSelectorInBackground:@selector(Gloabl_ImagePost:) withObject:PostData];
}

-(void)PostDataWithUrl:(NSString*)UrlString Body:(NSMutableData*)body Delegate:(id)Delegate Webservice:(NSInteger)WebserviceName
{
    _WebService_Identifier = WebserviceName;
    self.delegate = Delegate;
    NSMutableDictionary *PostData = [[NSMutableDictionary alloc] init];
    NSString *strurl = [NSString stringWithFormat:@"%@%@",MainUrl,UrlString];
    [PostData setValue:strurl forKey:@"URL"];
    [PostData setValue:body forKey:@"BODY"];
    [[ChatCommonMethodsViewController shared_Object] MBHUD_Start:nil];
    [self performSelectorInBackground:@selector(GloablPost:) withObject:PostData];

}

-(void)GloablPost:(NSDictionary*)PostData
{
    BOOL status = NO;
    NSArray *ParsedArray;
    id Result = [GlobalWebservice PostData:[PostData objectForKey:@"BODY"] Url:[PostData objectForKey:@"URL"]];
    if ([Result isKindOfClass:NSClassFromString(@"NSArray")]) {
        if ((NSNull*)[[Result objectAtIndex:0] objectForKey:@"status"]!= [NSNull null]) {
            status = [[[Result objectAtIndex:0] objectForKey:@"status"] isEqualToString:@"true"]?YES:NO;
            if (status) {
                ParsedArray = [[Result objectAtIndex:0] objectForKey:@"data"];
                [self performSelectorOnMainThread:@selector(CallDelegateOnMainThread:) withObject:ParsedArray waitUntilDone:YES];
            }
            else
            {
                NSString* Parsedstring = [[Result objectAtIndex:0] objectForKey:@"msg"];
                [self performSelectorOnMainThread:@selector(CallDelegateOnMainThread:) withObject:Parsedstring waitUntilDone:YES];
            }
        }
        else
        {
            [self performSelectorOnMainThread:@selector(CallDelegateOnMainThread:) withObject:@"404" waitUntilDone:YES];
        }
       
    }
}


-(void)Gloabl_ImagePost:(NSDictionary*)PostData
{
    
    BOOL status = NO;
    status = [GlobalWebservice PostImage:[PostData objectForKey:@"BODY"] DataForImage:nil Url:[PostData objectForKey:@"URL"]];
    
    if(status)
    {
        _WebService_Identifier = Webservice_Login;
        isFacebookLogin =YES;
    }
}

+(NSMutableData*)AddImage_UIImage:(UIImage*)image ImageName:(NSString*)ImageName
{
    //    if (!Body) {
    Body = [[NSMutableData alloc] init];
    //    }
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [Body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [Body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image[]\"; filename=\"%@.jpg\"\r\n", ImageName] dataUsingEncoding:NSUTF8StringEncoding]];
    [Body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [Body appendData:[NSData dataWithData:imageData]];
    return Body;
}

#pragma mark owner_Restro

-(void)StoreList:(UIView*)view Delegate:(id)Delegate User_Id:(NSString*)UserId
{
    self.delegate=Delegate;
     _WebService_Identifier = Webservice_StoreList;
     NSString *strurl = [NSString stringWithFormat:@"store_list.php?user_id=%@",[DineWebserviceClass SharedObject].user_id];
     [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)OwnerCouponList:(UIView*)view Delegate:(id)Delegate User_Id:(NSString*)UserId
{
     self.delegate=Delegate;
     _WebService_Identifier = Webservice_OwnerCouponList;
     NSString *strurl = [NSString stringWithFormat:@"owner_coupon_list.php?user_id=%@",[DineWebserviceClass SharedObject].user_id];
     [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)AddStore:(UIView*)view Delegate:(id)Delegate User_Id:(NSString*)UserId Name:(NSString*)name
{
     self.delegate=Delegate;
     _WebService_Identifier = Webservice_AddStore;
     NSString *strurl = [NSString stringWithFormat:@"store_add.php?user_id=%@&name=%@",[DineWebserviceClass SharedObject].user_id, name];
     [self Webservice:strurl SelfViewForActivityIndicator:view];
}
-(void)EditStore:(UIView*)view Delegate:(id)Delegate User_Id:(NSString*)UserId Name:(NSString*)name StoreId:(NSString*)storeId
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_AddStore;
    NSString *strurl = [NSString stringWithFormat:@"store_add.php?user_id=%@&name=%@&store_id=%@",[DineWebserviceClass SharedObject].user_id, name, storeId];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)OwnerRegistration:(UIView*)view Delegate:(id)Delegate Name:(NSString*)name UserName:(NSString*)username Password:(NSString*)password Email:(NSString*)email Type:(NSString*)type PackId:(NSString*)packId Payment:(NSString*)payment
{
     self.delegate=Delegate;
     _WebService_Identifier = Webservice_Owner_registration;
     NSString *strurl = [NSString stringWithFormat:@"owner_reg.php?name=%@&username=%@&password=%@&email=%@&type=%@&packid=%@&payment=%@",name, username, password, email, type,packId,payment];
     [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)CouponType:(UIView*)view Delegate:(id)Delegate
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_CouponType;
    NSString *strurl = [NSString stringWithFormat:@"coupon_type.php"];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)CategoryList:(UIView*)view Delegate:(id)Delegate
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_CategoryList;
    NSString *strurl = [NSString stringWithFormat:@"category_list.php"];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)PrintCouponLog:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)UserID CouponID:(NSString*)CouponId
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_PrintCouponLog;
    NSString *strurl = [NSString stringWithFormat:@"print_coupon_log.php?user_id=%@&coupon_id=%@",[DineWebserviceClass SharedObject].user_id, CouponId];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

#pragma mark Post Methods

-(void)AllocPostData
{
    if (PostDataBody == nil) {
        PostDataBody = [[NSMutableData alloc] init];
    }
}
+(NSMutableData*)SetPostData:(id)getPostdata ForKey:(NSString*)Key UserIdIfSendingImage:(NSString*)userid PostBody:(NSMutableData*)data
{
    [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    if ([getPostdata isKindOfClass:NSClassFromString(@"NSString")]) {
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@",Key,getPostdata] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    else if ([getPostdata isKindOfClass:NSClassFromString(@"NSArray")])
    {
        for (id d in getPostdata)
        {
            [data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@[]\"\r\n\r\n%@",Key,d] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    else if ([getPostdata isKindOfClass:NSClassFromString(@"NSData")])
    {
        NSString *strUnique = [NSString stringWithFormat:@"%@%@",[DineWebserviceClass SharedObject].user_id,[ChatCommonMethodsViewController getCurrentDate]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@[]\"; filename=\"%@.jpg\"\r\n",Key, strUnique] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:getPostdata];
    }
    
    return data;

}
+(NSMutableURLRequest*)GetPostRequest:(NSMutableData*)body Url:(NSString*)urlString
{
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    return request;
}

-(void)GetOwnerInfo:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)UserID
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_OwnerInfo;
    NSString *strurl = [NSString stringWithFormat:@"user_info.php?userid=%@",[DineWebserviceClass SharedObject].user_id];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)DeleteStore:(UIView*)view Delegate:(id)Delegate StoreId:(NSString*)storeid
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_DeleteStore;
    NSString *strurl = [NSString stringWithFormat:@"delete_store.php?store_id=%@",storeid];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}
-(void)DeleteCoupon:(UIView*)view Delegate:(id)Delegate CouponId:(NSString*)CouponId
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_DeleteStore;
    NSString *strurl = [NSString stringWithFormat:@"delete_coupon.php?coupon_id=%@",CouponId];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)Forgotpassword:(UIView*)view Delegate:(id)Delegate EmailId:(NSString*)emailId
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_Forgotpassword;
    NSString *strurl = [NSString stringWithFormat:@"password_reset.php?email=%@",emailId];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)GetPackageList:(UIView*)view Delegate:(id)Delegate
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_Packageget;
    NSString *strurl = @"package_list.php";
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)CheckRegistration:(UIView*)view Delegate:(id)Delegate Username:(NSString*)username Email:(NSString*)email
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_CheckReg;
    NSString *strurl = [NSString stringWithFormat:@"check_reg.php?username=%@&email=%@",username,email];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}

-(void)AccountUpdate:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)userID Name:(NSString*)name Username:(NSString*)username Email:(NSString*)email Password:(NSString*)Password Phone:(NSString*)Phone
{
    self.delegate=Delegate;
    _WebService_Identifier = Webservice_AccountUpdate;
    NSString *strurl = [NSString stringWithFormat:@"user_info_edit.php?id=%@&name=%@&username=%@&email=%@&password=%@&phone=%@",userID, name, username,email, Password, Phone];
    [self Webservice:strurl SelfViewForActivityIndicator:view];
}


@end

