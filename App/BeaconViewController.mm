//
//  BeaconViewController.m
//  AudioCompass
//
//  Created by Joakim Bording on 17.02.12 - joakim@bording.no - joakim.bording.no
//  This work is shared under the creative common license: Attribution-NonCommercial ShareAlike 3.0 Unported 
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  Author should always be credited 
//

#import <CoreData/CoreData.h>
#import <AVFoundation/AVFoundation.h>

#import "BeaconViewController.h"
#import "RoundDividerViewController.h"
#import "TestData.h"

#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) / (float)M_PI * 180.0f)
#define radianConst M_PI/180.0

const int   INTERFACE_UPDATETIME    = 2000;       // 50ms update for interface


@implementation BeaconViewController

@synthesize managedObjectContext;
@synthesize testDataViewController;
@synthesize setupTypeOrder;
@synthesize player;
@synthesize repetitions;
@synthesize showArrow;

- (void)dealloc 
{
    [super dealloc];
    [managedObjectContext release];
    [setupTypeOrder release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *)managedContext
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.managedObjectContext = managedContext;
        self.title = NSLocalizedString(@"Test", @"Test");
        //srandom(time(NULL));
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"!! ViewDidLoad"); 
    [super viewDidLoad];
    [self testSetup];
}

- (void)viewWillAppear:(BOOL)animated
{
     NSLog(@"!! ViewWillAppear");

//    [self createAudioSession];
    
    [self sensorSetup];   
    if(!showArrow) arrowImage.hidden = YES;
    [super viewWillAppear:animated];  
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"!! ViewDidAppear");     
        
    //NSLog(@"First Responder - %d", [self isFirstResponder]);
    
    [self roundSetup];
    
    if(setupRound > roundCount) {
        // Close the view if the test is done
        [self.navigationController popViewControllerAnimated:YES];    
    } else {
        if(![player isPlaying]) [player play];
    }
    
    [super viewDidAppear:animated];    

}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"!! ViewWillDisappear"); 
    [super viewWillDisappear:animated]; 
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self sensorEnd];    
    [self soundEnd]; 
    
	[super viewDidDisappear:animated];
    NSLog(@"!! ViewDidDisappear");   
}

- (void)viewDidUnload
{
    NSLog(@"!! ViewDidUnload");
    [super viewDidUnload];
}

#pragma mark - Round handling

int randomSort(id obj1, id obj2, void *context ) {
    // returns random number -1 0 1
    return (arc4random()%3 - 1);    
}

- (int) returnUserNum
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TestData" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"userNum"];
    NSExpression *maxUserNumExpression = [NSExpression expressionForFunction:@"max:" arguments:[NSArray arrayWithObject:keyPathExpression]];
    NSExpressionDescription *expressionDescription = [[[NSExpressionDescription alloc] init] autorelease];
    [expressionDescription setName:@"maxUserNum"];
    [expressionDescription setExpression:maxUserNumExpression];
    [expressionDescription setExpressionResultType:NSDecimalAttributeType];
    [request setPropertiesToFetch:[NSArray arrayWithObject:expressionDescription]];
    NSError *error = nil;
    
    NSArray *objects = [managedObjectContext executeFetchRequest:request error:&error];
    if (objects == nil) {
        // Handle the error.
        return 0;
    }
    else {
        if ([objects count] > 0) {
            int currentMaxNum = (int) [[[objects objectAtIndex:0] valueForKey:@"maxUserNum"] integerValue];
            NSLog(@"!! MAXUSER:%i", currentMaxNum);
            return currentMaxNum + 1;
        } else {
            return 0;
        }
    }
}

-(NSString*) typeDescription:(NSString*) setup {
    NSString* ret = [[[NSString alloc] init] autorelease];
    
    if([setup isEqualToString:@"ApplePurrPandoraLoop"]){
        ret = @"The sound will repeat";
    } else if([setup isEqualToString:@"ApplePurrPandora"]){
        ret = @"The sound will only be audible once";        
    } else if([setup isEqualToString:@"ApplePurrPanning"]){
        ret = @"The sound will only be audible once";       
    } else if([setup isEqualToString:@"ApplePurrPanningLoop"]){
        ret = @"The sound will repeat";  
    } else if([setup isEqualToString:@"ToneFrequencyLoop"]){
        ret = @"The highest tone indicates the direction";         
    } else {
        ret = @"";
    }
    return ret;
}

- (void) testSetup
{

    self.setupTypeOrder = [NSMutableArray arrayWithObjects:@"ApplePurrPandora",@"ApplePurrPanning",@"ApplePurrPanningLoop", @"ApplePurrPandoraLoop", @"ApplePurrPandoraNav2", @"ApplePurrPandoraNav2Loop", nil];   
    
    //self.setupTypeOrder = [NSMutableArray arrayWithObjects:@"ApplePurrPandora", @"ApplePurrPanning",  @"ApplePurrPandoraLoop", @"ApplePurrPanningLoop", nil];

    // RANDOM
    [setupTypeOrder sortUsingFunction:randomSort context:nil];

    // Generate new user number
    userNum = [self returnUserNum]; // ### Need to be generated
    if(repetitions && repetitions > 0) roundAimCount = [repetitions intValue];
    else roundAimCount = 13;
    numTotalLabel.text = [NSString stringWithFormat:@"of %i", roundAimCount];
    aimNum = 0; //First saved aimNum will be 1
    setupRound = 0; //First saved setupRound will be 1
    roundCount = [setupTypeOrder count];    
    
    [self openRoundDivider]; 
}

- (void) roundSetup
{
    setupRound++;
    aimNum = 0;
    
    // Determine if end of test is reached
    if(setupRound > roundCount) {
        // End the test by closing the view
        // Is executed in viewDidAppear
        
    } else {
    
        // Determine new setupType
        setupType = [setupTypeOrder objectAtIndex:(setupRound - 1)];
        
        // **Set FMOD sounds
        [self soundSetup];
    
        // Set random position
        // The first position is always north. Do we need to make it random? 
        [self aimSetup];
    }
}

- (void) aimSetup
{
    aimNum++;
    numHitsLabel.text = [NSString stringWithFormat:@"%d", aimNum];
    double _compiledHeading = compiledHeading;
    // Make new direction
    startOffset = (arc4random()%360);
    northOffset = northOffset + startOffset;  
  
    if(_compiledHeading > 180.0f) startOffset = 360 - _compiledHeading + startOffset;
    else startOffset = _compiledHeading + startOffset;
    if(startOffset > 360.0f) startOffset = startOffset - 360.0f;
    
    
    if(northOffset > 360) northOffset = northOffset - 360;
    
    // Set start time
    timeLastBeacon = [[NSDate date] retain];
    
    hitButton.enabled = TRUE;    
    
    // Play sound event
    [self soundPlay];
}

-(void) delayAfterAimGivenProceed:(NSTimer*) sender
{
    [self aimSetup];
}

- (void) aimGiven
{
    [self soundStop];
    hitButton.enabled = FALSE;
    
    // Store hit offset
    float _beaconOffset = beaconOffset;
    float _beaconDirectionOffset = compiledHeading;
    if(_beaconDirectionOffset > 180.0f) _beaconDirectionOffset = (360.0f - compiledHeading) * -1.0f;
    
    double _timeSinceLast = [[NSDate date] timeIntervalSinceDate:timeLastBeacon];
    [timeLastBeacon release];
    //setupRound
    //setupType
    //aimNum
    //beaconStartAngle
    //userNum
    
    // Save data
    TestData *testData = [NSEntityDescription insertNewObjectForEntityForName:@"TestData" inManagedObjectContext:self.managedObjectContext];
    testData.userNum = [NSNumber numberWithInt:userNum];
    testData.setupRound =  [NSNumber numberWithInt:setupRound];
    testData.setupType = setupType;
    testData.aimNum = [NSNumber numberWithInt:aimNum]; 
    testData.beaconStartOffset = [NSNumber numberWithDouble:startOffset]; // ENDRET FRA BEACONSTARTANGLE DEN 12. MARS    
    testData.beaconDirectionOffset = [NSNumber numberWithFloat:_beaconDirectionOffset]; 
    testData.beaconOffset = [NSNumber numberWithFloat:_beaconOffset];       
    testData.timeSinceLast = [NSNumber numberWithFloat:_timeSinceLast];      

    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
    
    
    // Save information
    NSLog(@"SAVED: userNum:%i setupRound:%i setupType:%@ aimNum:%i beaconOffset:%.1f beaconStartOffset:%.1f beaconDirectionOffset:%.1f timeSinceLast:%.1f",userNum,setupRound,setupType,aimNum,_beaconOffset,startOffset,_beaconDirectionOffset,_timeSinceLast); 
    
    // Issue vibrate
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    

    
    //If end of round is reached
    if(aimNum == roundAimCount){
        //[self soundEnd];
        [self tickDobbelPlay];
        [self openRoundDivider];
        
    } else {
        [self tickPlay];
        // Run [self aimgGiven]; after 1 second
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(delayAfterAimGivenProceed:) userInfo:nil repeats:NO];
    }

}

- (void) openRoundDivider
{
    NSString *roundTitle = [NSString stringWithFormat:@"Round %i", (setupRound + 1)];
    NSString *roundCaption, *roundButtonCaption, *typeCaption;
    
    if(setupRound == 0){
            roundCaption = @"Hit start when you are ready.";
            roundButtonCaption = @"Start";
        typeCaption = [self typeDescription:[setupTypeOrder objectAtIndex:0]]; 
    } else if(setupRound == roundCount){
        roundCaption = [NSString stringWithFormat:@"Thank you! You have completed the test as sser number %i", userNum];
        roundButtonCaption = @"Close";     
        typeCaption = @"";        
    } else {
        roundCaption = @"You have completed a round. Hit start when you are ready for the next.";
        roundButtonCaption = @"Start next round";    
        typeCaption = [self typeDescription:[setupTypeOrder objectAtIndex:(setupRound)]];        
    }
    

    
    RoundDividerViewController *roundView = [[[RoundDividerViewController alloc] initWithTitle:roundTitle caption:roundCaption buttonCaption:roundButtonCaption typeCaption:typeCaption] autorelease];
    
    [roundView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    UINavigationController *roundViewContr = [[[UINavigationController alloc] initWithRootViewController:roundView] autorelease];
    [self.navigationController presentModalViewController:roundViewContr animated:YES];  
}

#pragma mark - Sensor handling


/*
 * Starts the sound and log setup for each round
 *
 */

- (void) sensorSetup
{
    // Heading variables
    oldHeading                      = 0;
    lastCalibratedGyroscopeOffset   = 0;
    lastCalibratedMagneticHeading   = 0;
    numHits                         = 0;
    northOffset                     = 0;
    hitOffsets = [[NSMutableArray alloc] init];

    // Set up motionManager
    motionManager = [[CMMotionManager alloc]  init];
    motionManager.deviceMotionUpdateInterval = 0.02; //50Hz
    motionManager.accelerometerUpdateInterval = 0.04; //25Hz
    
    opQ = [[NSOperationQueue currentQueue] retain];
    opQ2 = [[NSOperationQueue currentQueue] retain];
    
    NSLog(@"Initializing Motion");
    
    if(motionManager.isDeviceMotionAvailable) {

        
        // Listen to events from the motionManager
        motionHandler = ^ (CMDeviceMotion *motion, NSError *error) {

            CMAttitude *currentAttitude = motion.attitude;
            float yawValue = currentAttitude.yaw; // Use the yaw value relative to gravity
            
            // Yaw values are in radians (-180 - 180), here we convert to degrees
            float yawDegrees = CC_RADIANS_TO_DEGREES(yawValue);
            currentYaw = yawDegrees;
            
            // We add new compass value together with new yaw value
            yawDegrees = lastCalibratedMagneticHeading + (yawDegrees - lastCalibratedGyroscopeOffset);
            
            // Degrees should always be between 0 and 360
            if(yawDegrees < 0) {
                yawDegrees = yawDegrees + 360;
            }
            if(yawDegrees > 360) {
                yawDegrees = yawDegrees - 360;
            }            
            
            // The resulting heading that is used for sound
            compiledHeading = yawDegrees + northOffset; 
            if(compiledHeading > 360) {
                compiledHeading = compiledHeading - 360;
            } 
            
            // The heading offset that is used for measures and sound choice
            float frontBackAngle = compiledHeading;
            if(frontBackAngle > 180.0f) frontBackAngle = 360.0f - frontBackAngle;
            beaconOffset = frontBackAngle;
                       
            float gyroDegrees = (compiledHeading*radianConst);
                       
            // If there is a new compass value the gyro graphic animates to this position
            if(updateCompass) {             
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.25];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [arrowImage setTransform:CGAffineTransformMakeRotation(gyroDegrees)];
                [UIView commitAnimations];
                updateCompass = NO;

            } else {
                arrowImage.transform = CGAffineTransformMakeRotation(gyroDegrees);
                //[self setSoundPosition];
            }
            
            if(soundPlaying){
                [soundView updateSoundAngle:compiledHeading];
            }
        };

        accelHandler = ^ (CMAccelerometerData *accelerometerData, NSError *error) {
            double newAccel = accelerometerData.acceleration.z;
            
            if(hitButton.enabled == TRUE && lastAcceleration > 0.0f && fabs(lastAcceleration - newAccel) > 1.2f){
                [self aimGiven];
            }
            
            lastAcceleration = newAccel;
        };
        
        
        // Start listening to motionManager events
        [motionManager startDeviceMotionUpdatesToQueue:opQ withHandler:motionHandler];
        [motionManager startAccelerometerUpdatesToQueue:opQ2 withHandler:accelHandler];
        
    } else {
        NSLog(@"No Device Motion on device.");
        [motionManager release];
    } 
}

- (void) sensorEnd 
{
    NSLog(@"Sensor End.");
    [motionManager stopDeviceMotionUpdates];
    [motionManager stopAccelerometerUpdates];
    //[magnetCalibrationTimer invalidate];
    [hitOffsets release];
    //[locationManager release];
    [motionManager release];
    updateCompass = NO;
}

#pragma mark - Sound handling

- (void) soundSetup
{
    soundView = [[SoundView alloc] initWithSetup:setupType];
    //[soundView playSoundFromAngle:compiledHeading];
}

- (void) soundPlay
{
    soundPlaying = TRUE;  
    [soundView playSoundFromAngle:compiledHeading];
}

- (void) tickPlay
{
    [soundView playTick];
}

- (void) tickDobbelPlay {
     [soundView playEnd];
    //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tickPlay) userInfo:nil repeats:NO];
    
}

- (void) soundStop
{
    [soundView stopSound];
}

- (void) soundEnd
{    
    [soundView stopSound];
    soundPlaying = FALSE;
    if(soundView) [soundView release];
}

#pragma mark - Interface handling

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)hitButtonTouched:(id)sender {
    
    [self aimGiven]; //Kaller selv aimSetup
    
    // Issue vibrate
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

}

@end
