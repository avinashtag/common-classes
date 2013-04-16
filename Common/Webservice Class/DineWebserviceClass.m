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


@interface DineWebserviceClass()
{
    NSString *UserId;
}

@end
@implementation DineWebserviceClass


static DineWebserviceClass* Object_Shared = Nil;
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

#pragma mark Add Image PostBody
+(NSMutableData*)AddImageToBody:(UIImage*)image ImageName:(NSString*)ImageName PostBody:(NSMutableData*)Body
{
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [Body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [Body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image[]\"; filename=\"%@.jpg\"\r\n", ImageName] dataUsingEncoding:NSUTF8StringEncoding]];
    [Body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [Body appendData:[NSData dataWithData:imageData]];
    return Body;
}



#pragma mark Webservice Call
-(void)Webservice:(NSString*)UrlString SelfViewForActivityIndicator:(UIView*)View
{
    
    [[ChatCommonMethodsViewController shared_Object] MBHUD_Start];
    [self performSelectorInBackground:@selector(makeRequest_GetMethod:) withObject:UrlString];
}

- (void)makeRequest_GetMethod:(NSString*)url_String
{
    
    @autoreleasepool
    {
        NSArray *data_Object = [GlobalWebservice ExecuteWebService:url_String];
    }
}


-(void)GetPostData:(NSString*)Url Body:(NSMutableData*)Body Delegate:(id)Delegate Webservice:(NSInteger)WebserviceName LoadView:(BOOL)Load
{
    
    if (Load) {
        [[ChatCommonMethodsViewController shared_Object] MBHUD_Start];
    }
    _WebService_Identifier = WebserviceName;
    self.delegate = Delegate;
    NSString* fullUrl = [NSString stringWithFormat:@"%@%@",MainUrl,Url];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:fullUrl,Body, nil] forKeys:[NSArray arrayWithObjects:@"url",@"Body", nil]];
      [self performSelectorInBackground:@selector(GloablPost:) withObject:dict];
}


-(void)GloablPost:(NSDictionary*)PostData
{
    BOOL status = NO;
    NSArray *Result = [GlobalWebservice PostData:[PostData objectForKey:@"Body"] Url:[PostData objectForKey:@"url"]];
    
    if ((NSNull*)[[Result objectAtIndex:0] objectForKey:@"status"]!= [NSNull null]) {
        status = [[[Result objectAtIndex:0] objectForKey:@"status"] isEqualToString:@"true"]?YES:NO;
        if (status) {
            Result = [[Result objectAtIndex:0] objectForKey:@"data"];
            [self performSelectorOnMainThread:@selector(CallDelegateOnMainThread:) withObject:Result waitUntilDone:YES];
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


#pragma mark Post Methods

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
        NSString *strUnique = [NSString stringWithFormat:@"%@%@",userid,[ChatCommonMethodsViewController getCurrentDate]];
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

-(void)CallDelegateOnMainThread:(id)response
{
    [[ChatCommonMethodsViewController shared_Object] MBHUD_Stop];
    if ([response isKindOfClass:NSClassFromString(@"NSArray")])
    {
        [self.delegate WebServiceLoadData:response Message:@""];
    }
    else if ([response isKindOfClass:NSClassFromString(@"NSString")])
    {
        [self.delegate WebServiceLoadData:@"" Message:response];
    }
}



@end

