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
#import "PostData.h"

@protocol WebServiceLoadData <NSObject>

typedef enum
{
    Webservice_Registration=0,
} WebServiceIdentifier;

@required
-(void)WebServiceLoadData:(id)DataModel Message:(NSString*)message;

@end
@interface DineWebserviceClass : NSObject
{
    PostData *postdataObject;
}
+(DineWebserviceClass*)SharedObject;
@property (nonatomic, strong)id<WebServiceLoadData>delegate;
@property (assign, nonatomic) NSInteger WebService_Identifier;

+(NSMutableData*)AddImageToBody:(UIImage*)image ImageName:(NSString*)ImageName PostBody:(NSMutableData*)Body;+(NSMutableData*)SetPostData:(id)getPostdata ForKey:(NSString*)Key UserIdIfSendingImage:(NSString*)userid PostBody:(NSMutableData*)data;
+(NSMutableURLRequest*)GetPostRequest:(NSMutableData*)body Url:(NSString*)urlString;
-(void)GloablPost:(NSDictionary*)PostData;
-(void)GetPostData:(NSString*)Url Body:(NSMutableData*)Body Delegate:(id)Delegate Webservice:(NSInteger)WebserviceName LoadView:(BOOL)Load;
@end
