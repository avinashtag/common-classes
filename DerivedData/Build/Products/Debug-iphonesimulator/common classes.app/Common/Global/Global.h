//
//  Global.h
//  SVB
//
//  Created by Samvit Infotech.
//  Copyright 2009 __MyCompanyName__Samvit Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum EnumMoodType{
	
	MOODTYPE_OK = 0,
	MOODTYPE_ENERGISED,
	MOODTYPE_ESTATIC,
	MOODTYPE_HAPPY,
	MOODTYPE_FRUSTRATED,
	MOODTYPE_ANGRY,
	MOODTYPE_TIRED,
	MOODTYPE_DEPRESSED,
	MOODTYPE_UNKNOWN = 999
	
} EnumMoodType;

typedef enum EnumSleepQualityType{
	
	SLEEPQUALITYTYPE_REFRESHED = 0,
	SLEEPQUALITYTYPE_VERYREFRESHED,
	SLEEPQUALITYTYPE_FATIGUED,
	SLEEPQUALITYTYPE_VERYFATIGUED,	
	SLEEPQUALITYTYPE_UNKNOWN = 999
	
} EnumSleepQualityType;


@interface Global : NSObject
{

}
+ (NSString*) GetDateString:(NSDate*)date;
+ (NSString*) GetChartAPIUrl:(NSDictionary*)chartData;

@end
