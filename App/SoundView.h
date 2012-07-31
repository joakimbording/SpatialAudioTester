//
//  SoundView.h
//  SoundGuide
//
//  Created by Joakim Bording on 17.02.12 - joakim@bording.no - joakim.bording.no
//  This work is shared under the creative common license: Attribution-NonCommercial ShareAlike 3.0 Unported 
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  Author should always be credited 
//

#import <Foundation/Foundation.h>

#import "fmod_event.hpp"
#import "fmod_errors.h"
#import "fmodiphone.h"

@interface SoundView : NSObject {  
    bool                soundPlaying;
    bool                use3D;
    bool                loopEvent;
    NSString            *setup;
    NSTimer             *loopTimer;
    double              lastAngle;
    
    //FMOD
    FMOD::EventSystem   *eventSystem;  
    FMOD::Channel       *channel1;
    FMOD::EventCategory *masterCategory;
    
    FMOD::Event         *tickEvent;  
    FMOD::Event         *endEvent;  
    FMOD::Event         *beaconEvent;
    FMOD::Event         *maskingEvent;
    FMOD::EventParameter *beaconParam;
    FMOD::EventParameter *maskingParam;    
}

-(id) initWithSetup:(NSString*) setupType;
-(void) fmodSetup;
-(void) eventsSetup;
-(void) playAfterLoop:(NSTimer *)timer;
-(void) playSoundFromAngle:(double) soundAngle;
-(void) updateSoundAngle:(double) soundAngle;
-(void) stopSound;
-(void) playEnd;
-(void) playTick;

@end
