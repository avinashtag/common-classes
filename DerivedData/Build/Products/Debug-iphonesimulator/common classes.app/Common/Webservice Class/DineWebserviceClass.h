//
//  DineWebserviceClass.h
//  DineForDime
//
//  Created by Vertax on 18/02/13.
//  Copyright (c) 2013 Vertax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJSON.h"
#import "DineWebserviceSwitch.h"

static NSString *CouponTypeDeal = @"4";
static NSString *CouponTypeAffiliate = @"3";
static NSString *CouponTypeDealPrintable = @"2";
static NSString *CouponTypeDealVoucher = @"1";
@protocol WebServiceLoadData <NSObject>

typedef enum
{
    Webservice_Registration=0,
    Webservice_Login,
    Webservice_Feedback,
    Webservice_VoucherList,
    Webservice_HomeList,
    Webservice_AddToFavourites,
    Webservice_MyVoucherList,
    Webservice_ExpiredVoucher,
    Webservice_ExistingCoupon,
    Webservice_ExistingVoucher,
    Webservice_CheckValid,
    Webservice_Redeem,
    Webservice_Rate,
    // Owner_Restro
    Webservice_StoreList,
    Webservice_OwnerCouponList,
    Webservice_AddStore,
    Webservice_Owner_registration,
    Webservice_CouponType,
    Webservice_CategoryList,
    Webservice_PrintCouponLog,
    
    Webservice_AddCoupon,
    Webservice_OwnerInfo,
    Webservice_DeleteStore,
    Webservice_Forgotpassword,
    Webservice_Packageget,
    Webservice_CheckReg,
    Webservice_AccountUpdate,
} WebServiceIdentifier;

@required
-(void)WebServiceLoadData:(id)DataModel Message:(NSString*)message;

@end
@interface DineWebserviceClass : NSObject


+(DineWebserviceClass*)SharedObject;
@property (nonatomic, strong)id<WebServiceLoadData>delegate;
@property (assign,nonatomic) BOOL isFacebookLogin;
@property (nonatomic, strong) NSString *pack_id;
@property (assign, nonatomic) NSInteger WebService_Identifier;
-(void)Registration_Name:(NSString*)Name Username:(NSString*)username Password:(NSString*)password EmailAddress:(NSString*)EmailAddress selfView:(UIView*)view;
-(void)Login:(NSString*)Username Password:(NSString*)password selfView:(UIView*)view Delegate:(id)Delegate;
-(void)Feedback_name:(NSString*)name Email:(NSString*)email_address comment:(NSString*)comment selfView:(UIView*)view;
-(void)VoucherList:(UIView*)View  Delegate:(id)Delegate Category :(NSInteger)category;
-(void)HomeList:(UIView*)view Delegate:(id)Delegate;
-(void)Myfavourites:(UIView*)view Delegate:(id)Delegate UserId :(NSString*)UserID;
-(void)MyVoucherList:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)Userid;
-(void)PrintCoupon:(UIView*)view Delegate:(id)Delegate CouponId:(NSString*)couponId UserId:(NSString*)Userid;
-(void)Rate:(UIView*)view Delegae:(id)Delegate Coupon_id:(NSString*)coupon_id User_id:(NSString*)User_id rate_atmosphere:(NSString*)rate_atmosphere rate_food:(NSString*)rate_food rate_service:(NSString*)rate_service rate_location:(NSString*)rate_location comment:(NSString*)comment;
@property (strong,nonatomic) NSString *user_id;
@property (strong,nonatomic) NSString *couponCode;
-(void)PostImage:(NSMutableData*)Body userId:(NSString*)userId email:(NSString*)email Delegate:(id)Delegate;
+(NSMutableData*)AddImage_UIImage:(UIImage*)image ImageName:(NSString*)ImageName;
-(void)ExpiredVouchers:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)Userid;
-(void)ExistingCoupons:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)Userid;
-(void)ExistingVoucher:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)Userid;
-(void)AddTofavourites:(UIView*)view Delegate:(id)Delegate Coupon_id:(NSString*)Coupon_id UserId :(NSString*)UserID;
-(void)Redeem:(UIView*)view Delegate:(id)Delegate Coupon_Id:(NSString*)coupon_id;

//Owner_Restro
-(void)StoreList:(UIView*)view Delegate:(id)Delegate User_Id:(NSString*)UserId;
-(void)OwnerCouponList:(UIView*)view Delegate:(id)Delegate User_Id:(NSString*)UserId;
-(void)AddStore:(UIView*)view Delegate:(id)Delegate User_Id:(NSString*)UserId Name:(NSString*)name;
-(void)EditStore:(UIView*)view Delegate:(id)Delegate User_Id:(NSString*)UserId Name:(NSString*)name StoreId:(NSString*)storeId;
-(void)OwnerRegistration:(UIView*)view Delegate:(id)Delegate Name:(NSString*)name UserName:(NSString*)username Password:(NSString*)password Email:(NSString*)email Type:(NSString*)type PackId:(NSString*)packId Payment:(NSString*)payment;

-(void)CouponType:(UIView*)view Delegate:(id)Delegate;
-(void)CategoryList:(UIView*)view Delegate:(id)Delegate;
-(void)PrintCouponLog:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)UserID CouponID:(NSString*)CouponId;

+(NSMutableData*)SetPostData:(id)getPostdata ForKey:(NSString*)Key UserIdIfSendingImage:(NSString*)userid PostBody:(NSMutableData*)data;
-(void)PostDataWithUrl:(NSString*)UrlString Body:(NSMutableData*)body Delegate:(id)Delegate Webservice:(NSInteger)WebserviceName;
+(NSMutableURLRequest*)GetPostRequest:(NSMutableData*)body Url:(NSString*)urlString;
-(void)GetOwnerInfo:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)UserID;

-(void)DeleteStore:(UIView*)view Delegate:(id)Delegate StoreId:(NSString*)storeid;
-(void)DeleteCoupon:(UIView*)view Delegate:(id)Delegate CouponId:(NSString*)CouponId;
-(void)Forgotpassword:(UIView*)view Delegate:(id)Delegate EmailId:(NSString*)emailId;
-(void)GetPackageList:(UIView*)view Delegate:(id)Delegate;
-(void)CheckRegistration:(UIView*)view Delegate:(id)Delegate Username:(NSString*)username Email:(NSString*)email;
-(void)AccountUpdate:(UIView*)view Delegate:(id)Delegate UserId:(NSString*)userID Name:(NSString*)name Username:(NSString*)username Email:(NSString*)email Password:(NSString*)Password Phone:(NSString*)Phone;
@end
