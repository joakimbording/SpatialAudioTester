//
//  SoundView.m
//  SoundGuide
//
//  Created by Joakim Bording on 17.02.12 - joakim@bording.no - joakim.bording.no
//  This work is shared under the creative common license: Attribution-NonCommercial ShareAlike 3.0 Unported 
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  Author should always be credited 
//

#import "SoundView.h"

void ERRCHECK(FMOD_RESULT result);

@implementation SoundView

// FMOD Spesific error check
void ERRCHECK(FMOD_RESULT result)
{
    if (result != FMOD_OK) {
        fprintf(stderr, "FMOD error! (%d) %s\n", result, FMOD_ErrorString(result));
        exit(-1);
    }
}

-(id) initWithSetup:(NSString*) setupType {
    self = [super init];
    if(self){    
        setup = setupType;  
        use3D = NO;        
        [self fmodSetup];
        [self eventsSetup];    
    }
    return self;
}

- (void)dealloc 
{
    [super dealloc];
    if (eventSystem) eventSystem->release();
    eventSystem = NULL;    
}

-(void) fmodSetup {
    NSLog(@"Initializing FMOD");
    
    FMOD_RESULT result = FMOD_OK;
    char buffer[200] = {0};
    
    // FMOD Setup
    eventSystem = NULL;
    masterCategory  = NULL;
    
    result = FMOD::EventSystem_Create(&eventSystem); 
    ERRCHECK(result);
    
    FMOD_IPHONE_EXTRADRIVERDATA extradriverdata; 
    memset(&extradriverdata, 0, sizeof(FMOD_IPHONE_EXTRADRIVERDATA));
    extradriverdata.sessionCategory = FMOD_IPHONE_SESSIONCATEGORY_MEDIAPLAYBACK; 
    extradriverdata.forceMixWithOthers = true;
    
    result = eventSystem->init(32, FMOD_INIT_NORMAL | FMOD_INIT_ENABLE_PROFILE, &extradriverdata, FMOD_EVENT_INIT_NORMAL);
    ERRCHECK(result);
    
    // Turns down the volume of music playing to let icons be heard
    result = FMOD_IPhone_DuckOtherAudio(true); ERRCHECK(result);
    
    [[NSString stringWithFormat:@"%@/AudioCompass.fev", [[NSBundle mainBundle] resourcePath]] getCString:buffer maxLength:200 encoding:NSASCIIStringEncoding];
    result = eventSystem->load(buffer, NULL, NULL);
    ERRCHECK(result);   
}

-(void) eventsSetup {
    FMOD_RESULT result = FMOD_OK;
    
    // Load Event sounds
    
    NSLog(@"%@", setup);
    
    if([setup isEqualToString:@"Beacon3DLoop"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/BeaconSynthAPandora", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = YES;
        use3D = NO;
    } else if([setup isEqualToString:@"Beacon3DSingle"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/BeaconSynthAPandora", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
        use3D = NO;        
    } else if([setup isEqualToString:@"Beacon2DLoop"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/Beacon", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = YES;
        use3D = YES;        
    } else if([setup isEqualToString:@"Beacon2DSingle"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/Beacon", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
        use3D = YES;        
    } else if([setup isEqualToString:@"SePaaMeg3DLoop"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/SePaaMeg", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = YES;
        use3D = NO;     
        
    } else if([setup isEqualToString:@"KnipsPandora"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/KnipsPandora", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
        use3D = NO;     
    } else if([setup isEqualToString:@"AppleGlassPandora"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/AppleGlassPandora", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
        use3D = NO;       
    } else if([setup isEqualToString:@"SynthPandora"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/SynthPandora", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
        use3D = NO;    
        
    } else if([setup isEqualToString:@"ApplePurrPandora"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/ApplePurrPandora", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
        use3D = NO;            
    } else if([setup isEqualToString:@"ApplePurrPandoraLoop"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/ApplePurrPandora", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = YES;
        use3D = NO;  
    } else if([setup isEqualToString:@"ApplePurrPanning"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/ApplePurrPanning", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
        use3D = YES;  
    } else if([setup isEqualToString:@"ApplePurrPanningLoop"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/ApplePurrPanning", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = YES;
        use3D = YES;     
    } else if([setup isEqualToString:@"ToneFrequencyLoop"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/ToneFrequency", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
        use3D = NO;   

    } else if([setup isEqualToString:@"SePaaMegPandora"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/SePaaMeg", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
        use3D = NO;           
    } else if([setup isEqualToString:@"ApplePurrPandoraNav2"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/ApplePurrPandoraNav2", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
        use3D = NO;   
    } else if([setup isEqualToString:@"ApplePurrPandoraNav2Loop"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/ApplePurrPandoraNav2", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = YES;
        use3D = NO;          
    } else if([setup isEqualToString:@"ApplePurrPandoraReverb"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/ApplePurrPandoraReverb", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
    } else if([setup isEqualToString:@"EnsoniqPandora"]){
        result = eventSystem->getEvent("AudioCompass/Audicons/EnsoniqPandora", FMOD_EVENT_DEFAULT, &beaconEvent);
        ERRCHECK(result);
        loopEvent = NO;
        use3D = NO;     
    }

    if(use3D){
        // Setup listener for 3D events
        FMOD_VECTOR listenerPos = { 1.0f, 0.0f, 1.0f };
        result = eventSystem->set3DListenerAttributes(0, &listenerPos,NULL,NULL,NULL);
        ERRCHECK(result);
    }
    
    result = eventSystem->getEvent("AudioCompass/Audicons/Off", FMOD_EVENT_DEFAULT, &endEvent);
    ERRCHECK(result);      

    result = eventSystem->getEvent("AudioCompass/Audicons/Ticker", FMOD_EVENT_DEFAULT, &tickEvent);
    ERRCHECK(result); 
    
    result = eventSystem->getCategory("master", &masterCategory);
    ERRCHECK(result);
    
    result = beaconEvent->getParameter("BeaconAngle", &beaconParam);
    ERRCHECK(result);    
    
    result = eventSystem->update();
    ERRCHECK(result);
}

-(void) _setSoundPosition:(double) soundAngle {
    FMOD_RESULT result = FMOD_OK;  
    
    lastAngle = soundAngle;
    
    if(use3D){
        FMOD_VECTOR listenerVel = {  0.0f, 0.0f, 0.0f };
        FMOD_VECTOR beaconPos = {  0.0f, 0.0f, 1.0f };
        
        double DISTANCEFACTOR = 0.5f; // Units per meter, i.e feet would = 3.28, centimeters would = 100
        
        beaconPos.x = DISTANCEFACTOR*sin(soundAngle*M_PI*1/180);
        beaconPos.z = DISTANCEFACTOR*cos(soundAngle*M_PI*-1/180); 
        
        result = beaconEvent->set3DAttributes(&beaconPos,&listenerVel);
        ERRCHECK(result);
    }
    
    if(soundAngle > 180) soundAngle = (360 - soundAngle)*-1;
    
    result = beaconParam->setValue(soundAngle);
    ERRCHECK(result); 
}

-(void) playAfterLoop:(NSTimer *)timer  {
    if(loopTimer != nil){
        FMOD_RESULT result = FMOD_OK;      
        [self _setSoundPosition:lastAngle];
        
        result = beaconEvent->stop();
        ERRCHECK(result);             
        result = beaconEvent->start();
        ERRCHECK(result);      

    }
}

-(void) playSoundFromAngle:(double) soundAngle {
    NSLog(@"FMOD playSound Ang:%0.1f",soundAngle);
    FMOD_RESULT result = FMOD_OK;  
   
    
    if(loopEvent){
        loopTimer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(playAfterLoop:) userInfo:nil repeats:YES];
    }
    
    [self _setSoundPosition:soundAngle];
     
    result = beaconEvent->start();
    ERRCHECK(result); 
}

-(void) updateSoundAngle:(double) soundAngle{
    //NSLog(@"FMOD updateSound Ang:%0.1f",soundAngle);
    FMOD_RESULT result = FMOD_OK;  
    
    [self _setSoundPosition:soundAngle];
    
    result = eventSystem->update();
    ERRCHECK(result);     
}

-(void) stopSound {
    NSLog(@"FMOD stopSound");

    FMOD_RESULT result = FMOD_OK;  
    
    result = beaconEvent->stop();
    
    if(loopEvent){
        [loopTimer invalidate];
        loopTimer = nil;
    }
    
    ERRCHECK(result);  
}

-(void) playEnd {
    NSLog(@"FMOD playEnd");    
    FMOD_RESULT result = FMOD_OK;  
    
    result = endEvent->start();
    ERRCHECK(result);
}

-(void) playTick {
    NSLog(@"FMOD playTick");    
    FMOD_RESULT result = FMOD_OK;  
    
    result = tickEvent->setVolume(0.5f);
    ERRCHECK(result); 
    
    result = tickEvent->start();
    ERRCHECK(result);    
}

@end
