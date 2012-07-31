//
//  TestData.h
//  AudioCompass
//
//  Created by Joakim Bording on 17.02.12 - joakim@bording.no - joakim.bording.no
//  This work is shared under the creative common license: Attribution-NonCommercial ShareAlike 3.0 Unported 
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  Author should always be credited 
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TestData : NSManagedObject // Denne var tidligere automatisk satt til NSManagedObjectModel tror jeg - som produserte feilmeldinger..

@property (nonatomic, retain) NSNumber * setupRound;
@property (nonatomic, retain) NSString * setupType;
@property (nonatomic, retain) NSNumber * aimNum;
@property (nonatomic, retain) NSNumber * beaconOffset;
@property (nonatomic, retain) NSNumber * beaconStartOffset;
@property (nonatomic, retain) NSNumber * beaconDirectionOffset;
@property (nonatomic, retain) NSNumber * timeSinceLast;
@property (nonatomic, retain) NSNumber * userNum;

@end
