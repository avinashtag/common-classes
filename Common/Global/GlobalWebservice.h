//
//  GlobalWebservice.h
//  SVB
//
//  Created by Samvit Infotech.
//  Copyright 2009 Samvit Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

@interface GlobalWebservice : NSObject <UIAlertViewDelegate> {

	NSMutableData* responseData;
}

+ (BOOL) IsServerReachable;
+(NSArray*)GetDataFromJsonParser:(NSURL *)urlstring;
+(NSDate*)GetDateFromEpochFormat:(NSString*)dateInEpochFormat;
+(NSString*)GetStringInActualForm:(NSString*)InputString;
+(NSString *)GetFormatedString:(NSString*)stringWithHtmlIncluded;
+ (NSArray*) ExecuteWebService:(NSString*)urlParameters;
+ (NSArray*) ExecuteWebServiceForUPC:(NSString*)urlParameters;



+(BOOL)PostImage:(NSMutableData*)body DataForImage:(NSDictionary*)dataforimage Url:(NSString*)urlString;
+(id)PostData:(NSMutableData*)body Url:(NSString*)urlString;
+(void)Debug:(NSString*)url Body:(NSMutableData*)body Response:(NSString*)response;
@end

