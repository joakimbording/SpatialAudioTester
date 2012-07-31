//
//  BeaconViewController.h
//  AudioCompass
//
//  Created by Joakim Bording on 17.02.12 - joakim@bording.no - joakim.bording.no
//  This work is shared under the creative common license: Attribution-NonCommercial ShareAlike 3.0 Unported 
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  Author should always be credited 
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h> // To vibrate
#import <AVFoundation/AVFoundation.h>
#import <math.h>

#import "TestDataViewController.h"
#import "SoundView.h"


@interface BeaconViewController : UIViewController {
    
    // Sensorhandling <AVAudioPlayerDelegate>
    //CLLocationManager   *locationManager;
    CMDeviceMotionHandler motionHandler;
    CMAccelerometerHandler accelHandler;
    CMMotionManager     *motionManager;
    NSOperationQueue    *opQ;
    NSOperationQueue    *opQ2;
    
    
    // Datahandling
    NSManagedObjectContext *managedObjectContext;
    TestDataViewController *testDataViewController;
    
    // Interface 
    IBOutlet UILabel    *numHitsLabel;
    IBOutlet UILabel    *numTotalLabel;     
    IBOutlet UIImageView *arrowImage;
    IBOutlet UIButton   *hitButton;  
    BOOL                showArrow;
    NSNumber            *repetitions;
    
  
    NSTimer             *magnetCalibrationTimer; 
    
    //FMOD
    SoundView           *soundView;
    
    // Sensor variables
    float               currentYaw; // Current relativ gyroscop yaw value with respect to gravity    
    float               updatedHeading; // Magnetic heading
    float               oldHeading; // Old magneting heading for calibration
    float               lastCalibratedGyroscopeOffset; // Latest gyroscope offset relative to magnetic heading
    float               lastCalibratedMagneticHeading; // Latest updated magnetic reading included northOffset
    float               compiledHeading; // Device heading calculated by updatedHeading - northOffset with currentYaw
    float               beaconOffset; // Current offset of beacon
    float               northOffset; // Offset of north direction
    double              startOffset; // Offset of the previous direction 
    float               directionalBeaconOffset; // Current offset of beacon (same as beaconOffset only negativ or positiv)
    bool                updateCompass;
    double              lastAcceleration;
    
    int                 numHits; // Number of hits made
    NSMutableArray      *hitOffsets; // Array of hit offsets
    
    CMQuaternion        lastQuaternionAngle;

    // Interface state variables
    bool                soundPlaying;
    int                 aimNum;
    int                 userNum;
    int                 setupRound;
    int                 roundCount;    
    int                 roundAimCount;
    NSString            *setupType;
    NSMutableArray      *setupTypeOrder; // Array of setupTypes for randomization
    NSDate              *timeLastBeacon;
    float               beaconStartAngle;
    
}

@property (nonatomic, retain) TestDataViewController *testDataViewController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *setupTypeOrder;
@property (nonatomic, retain) IBOutlet AVAudioPlayer *player;
@property (nonatomic, retain) NSNumber *repetitions;
@property (nonatomic) BOOL showArrow;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *)managedContext;
- (void) testSetup;
- (void) roundSetup;
- (void) aimSetup;
- (void) sensorSetup;
- (void) sensorEnd;
- (void) soundSetup;
- (void) soundPlay;
- (void) tickPlay;
- (void) tickDobbelPlay;
- (void) soundStop;
- (void) soundEnd;
- (void) openRoundDivider;
- (IBAction)hitButtonTouched:(id)sender;

- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent;
- (BOOL)canBecomeFirstResponder;

@end
