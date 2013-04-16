//  GlobalWebservice.m
//  SVB
//
//  Created by  Vertax.
//  Copyright 2009  Vertax. All rights reserved.
//

#import "GlobalWebservice.h"
#import "SBJSON.h"
#import "Constants.h"
#import "CFNetwork/CFHTTPMessage.h"
#import <SystemConfiguration/SCNetworkReachability.h>



@implementation GlobalWebservice
BOOL ServerIsReachable = FALSE;

#pragma mark Check network

+ (BOOL) IsServerReachable
{
	BOOL checkNetwork = YES;
    if (checkNetwork) { // Since checking the reachability of a host can be expensive, cache the result and perform the reachability check once.
        checkNetwork = NO;
		Boolean success;
		NSString* fullBaseUrl = MainUrl;
		NSString* baseUrlByTrimmingProtocol = [fullBaseUrl stringByReplacingOccurrencesOfString:@"http://"withString:@""];
		@try {
			NSRange range = [baseUrlByTrimmingProtocol rangeOfString:@"/"];
			if(range.location != NSNotFound)
            {
				baseUrlByTrimmingProtocol = [baseUrlByTrimmingProtocol substringToIndex:range.location];
				const char *host_name = [baseUrlByTrimmingProtocol UTF8String];
				SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
				SCNetworkReachabilityFlags flags;
				success = SCNetworkReachabilityGetFlags(reachability, &flags);
				ServerIsReachable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
				CFRelease(reachability);
			}
		}
		@catch (NSException * e) {
			NSLog(@"Exception occured : %@", [e description]);
		}
		@finally {
			
		}
	}
	
	if(! (ServerIsReachable) )
	{
		
		return FALSE;
	}
	else {
		return TRUE;
	}
}


+(NSArray*)GetDataFromJsonParser:(NSURL *)urlstring
{
	if(![[self class] IsServerReachable])
    {
		return nil;
	}	
	
	SBJsonParser* parser = [[SBJsonParser alloc] init];
	NSURLRequest *request = [NSURLRequest requestWithURL:urlstring];	
	NSData *response;
    NSError* error;
	@try{
		// Perform request and get JSON back as a NSData object
		response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSLog(@"%@",error.description);
	}
	@catch (id theException) {
		NSLog(@"Error");
	}

	// Get JSON as a NSString from NSData response
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];	
	
	json_string = [json_string stringByReplacingOccurrencesOfString:@"<string xmlns=\"http://schemas.microsoft.com/2003/10/Serialization/\">" withString:@""];
	json_string = [json_string stringByReplacingOccurrencesOfString:@"</string>" withString:@""];
	
	// Trimming the xml string from the string( if needed)
	NSRange startingRange = [json_string rangeOfString:@"<title>"];
	NSRange endRange = [json_string rangeOfString:@"</title>"];
	NSString* testString;
	if(endRange.length!=0)
	{
		NSRange jsonRange = NSMakeRange(startingRange.location+7, endRange.location - startingRange.location-7);
		
		testString=[json_string substringWithRange:jsonRange];
		
		if( [testString isEqualToString:@"ERROR: The requested URL could not be retrieved"])
		{
			
			UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Utapia" message:@"The requested url can not be retrived. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			alert = nil;
			return nil;		
		}
	}
	
	NSArray* statuses;
	// parse the JSON response into an object
	// Here we're using NSArray since we're parsing an array of JSON status objects
	
	id result = [parser objectWithString:json_string error:nil];
	
	if(result !=nil)
	{
		if( [result isKindOfClass:[NSArray class] ] ) {
			statuses = [parser objectWithString:json_string error:nil];
		}else if( [result isKindOfClass:[NSDictionary class] ]) {
			statuses = [NSArray arrayWithObject : [parser objectWithString:json_string error:nil] ];
		}else if([result isKindOfClass:[NSString class]]){
			
			statuses = [NSArray arrayWithObject:[result stringValue]];
		}
	}else {
		statuses = nil;
	}
	
	
	return statuses;	
}


+(NSDate*)GetDateFromEpochFormat:(NSString*)dateInEpochFormat
{
	NSRange  startDateRange=[dateInEpochFormat  rangeOfString:@"("];
	NSRange  endDateRange=[dateInEpochFormat rangeOfString:@")"];
	NSRange  DateRange=NSMakeRange(startDateRange.location+1, endDateRange.location-startDateRange.location-1);
	dateInEpochFormat=[dateInEpochFormat substringWithRange:DateRange];
	return [NSDate dateWithTimeIntervalSince1970:([dateInEpochFormat doubleValue]/1000)];
}

+(NSString*)GetStringInActualForm:(NSString*)InputString{
	
	InputString=[InputString stringByReplacingOccurrencesOfString:@"\\" withString:@"//"];
	return InputString;
	
}

+ (NSString *)GetFormatedString:(NSString*)stringWithHtmlIncluded
{
	stringWithHtmlIncluded=[stringWithHtmlIncluded stringByReplacingOccurrencesOfString:@"&amp;nbsp;" withString:@""];
	stringWithHtmlIncluded=[stringWithHtmlIncluded stringByReplacingOccurrencesOfString:@"&lt;br /&gt;" withString:@""];
	return stringWithHtmlIncluded;
}

+ (NSArray*) ExecuteWebService:(NSString*)urlParameters
{
	NSArray *webResult=nil;
	if([GlobalWebservice IsServerReachable])
	{
		NSString* urlString = [NSString stringWithFormat:@"%@%@",MainUrl,urlParameters];
		NSURL* url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"Full Url %@",url);
		webResult = [GlobalWebservice GetDataFromJsonParser:url];
	}
    else
    {
         [self performSelectorOnMainThread:@selector(errorAlert) withObject:@"Error 404" waitUntilDone:YES];
    }
    NSLog(@"Response %@",webResult);
	return webResult;
}
+ (void)errorAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Please Check Your Internet Connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];

}

+ (NSArray*) ExecuteWebServiceForUPC:(NSString*)urlParameters
{
	NSArray *webResult=nil;
	if([GlobalWebservice IsServerReachable])
	{
		NSURL* url=[NSURL URLWithString:[urlParameters stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		webResult = [GlobalWebservice GetDataFromJsonParser:url];
		
	}
	return webResult;
	
}

+(id)PostData:(NSMutableData*)body Url:(NSString*)urlString
{
    NSLog(@"url %@",urlString);

    if([GlobalWebservice IsServerReachable])
	{
        // setting up the request object now
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        // setting the body of the post to the reqeust
        [request setHTTPBody:body];
        // now lets make the connection to the web
        
        NSData *returnData ;
        returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"response %@",returnString);
        NSArray *arrpicResult = [returnString JSONValue];
        return arrpicResult;
    }
    return nil;
}

-(void)delegateCall:(id)data
{
    [[ChatCommonMethodsViewController shared_Object]MBHUD_Stop];
    
}


@end


