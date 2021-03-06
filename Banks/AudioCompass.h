/*
    AudioCompass.h
    Generated by FMOD Designer v4.38.5 
*/

#ifndef AUDIOCOMPASS_H
#define AUDIOCOMPASS_H

/*
    Total number of events in the project
*/
const int EVENTCOUNT_AUDIOCOMPASS = 23;

/*
    EventGroup/Event-relative indices
*/
const int EVENTGROUP_AUDIOCOMPASS_AUDICONS = 0;
const int EVENTGROUPCOUNT_AUDIOCOMPASS_AUDICONS = 23;
const int EVENT_AUDIOCOMPASS_AUDICONS_BEACON = 0;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_BEACON_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_ON = 1;
const int EVENT_AUDIOCOMPASS_AUDICONS_OFF = 2;
const int EVENT_AUDIOCOMPASS_AUDICONS_SUCCESS = 3;
const int EVENT_AUDIOCOMPASS_AUDICONS_ALERT = 4;
const int EVENT_AUDIOCOMPASS_AUDICONS_TICKER = 5;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_TICKER_FREQUENCE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_BEACONSYNTHAPANDORA = 6;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_BEACONSYNTHAPANDORA_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_BEACONSYNTHAPANDORA2 = 7;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_BEACONSYNTHAPANDORA2_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_BEACONSYNTHASTEREO = 8;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_BEACONSYNTHASTEREO_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_SEPAAMEG = 9;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_SEPAAMEG_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORAREVERB = 10;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORAREVERB_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_KNIPSPANDORA = 11;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_KNIPSPANDORA_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_KNIPSPANNING = 12;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_KNIPSPANNING_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_APPLEGLASSPANDORA = 13;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_APPLEGLASSPANDORA_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORA = 14;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORA_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_ENSONIQPANDORA = 15;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_ENSONIQPANDORA_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_APPLEPURRPANNING = 16;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_APPLEPURRPANNING_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORANAV = 17;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORANAV_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_SYNTHPANDORA = 18;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_SYNTHPANDORA_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORANAV2 = 19;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORANAV2_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_KNIPS = 20;
const int EVENT_AUDIOCOMPASS_AUDICONS_APPLEPURRFREQUENCY = 21;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_APPLEPURRFREQUENCY_BEACONANGLE = 0;
const int EVENT_AUDIOCOMPASS_AUDICONS_TONEFREQUENCY = 22;
const int EVENTPARAMETER_AUDIOCOMPASS_AUDICONS_TONEFREQUENCY_BEACONANGLE = 0;

/*
    Project-unique event ids
*/
const int EVENTID_AUDIOCOMPASS_AUDICONS_BEACON = 0;
const int EVENTID_AUDIOCOMPASS_AUDICONS_ON = 1;
const int EVENTID_AUDIOCOMPASS_AUDICONS_OFF = 2;
const int EVENTID_AUDIOCOMPASS_AUDICONS_SUCCESS = 3;
const int EVENTID_AUDIOCOMPASS_AUDICONS_ALERT = 4;
const int EVENTID_AUDIOCOMPASS_AUDICONS_TICKER = 5;
const int EVENTID_AUDIOCOMPASS_AUDICONS_BEACONSYNTHAPANDORA = 6;
const int EVENTID_AUDIOCOMPASS_AUDICONS_BEACONSYNTHAPANDORA2 = 7;
const int EVENTID_AUDIOCOMPASS_AUDICONS_BEACONSYNTHASTEREO = 8;
const int EVENTID_AUDIOCOMPASS_AUDICONS_SEPAAMEG = 9;
const int EVENTID_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORAREVERB = 10;
const int EVENTID_AUDIOCOMPASS_AUDICONS_KNIPSPANDORA = 11;
const int EVENTID_AUDIOCOMPASS_AUDICONS_KNIPSPANNING = 12;
const int EVENTID_AUDIOCOMPASS_AUDICONS_APPLEGLASSPANDORA = 13;
const int EVENTID_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORA = 14;
const int EVENTID_AUDIOCOMPASS_AUDICONS_ENSONIQPANDORA = 15;
const int EVENTID_AUDIOCOMPASS_AUDICONS_APPLEPURRPANNING = 16;
const int EVENTID_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORANAV = 17;
const int EVENTID_AUDIOCOMPASS_AUDICONS_SYNTHPANDORA = 18;
const int EVENTID_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORANAV2 = 19;
const int EVENTID_AUDIOCOMPASS_AUDICONS_KNIPS = 20;
const int EVENTID_AUDIOCOMPASS_AUDICONS_APPLEPURRFREQUENCY = 21;
const int EVENTID_AUDIOCOMPASS_AUDICONS_TONEFREQUENCY = 22;

const int EVENTCATEGORY_AUDIOCOMPASS_MASTER = 0;
const int EVENTCATEGORYCOUNT_AUDIOCOMPASS_MASTER = 26;

const int EVENTCATEGORY_AUDIOCOMPASS_MASTER_MUSIC = 0;
const int EVENTCATEGORYCOUNT_AUDIOCOMPASS_MASTER_MUSIC = 0;


/*
    Event GUIDs
*/
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_BEACON = "{8df78172-5655-4925-8b6e-369f4b82f2fe}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_ON = "{26972345-5d87-450f-b72c-0ae98612f29d}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_OFF = "{6f1e0490-70aa-422d-b016-ef8dd15007e3}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_SUCCESS = "{8e309652-b4d4-430a-b344-ea2f7ca548c7}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_ALERT = "{d67a1063-a779-46fe-9e97-80fdc0e935a8}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_TICKER = "{6b7559df-8474-4c88-9484-3d7550c43840}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_BEACONSYNTHAPANDORA = "{c7e149ed-c101-426e-935c-a34ea0482017}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_BEACONSYNTHAPANDORA2 = "{271246d2-c2d0-41de-a787-5335d2ef5ee3}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_BEACONSYNTHASTEREO = "{b2d78a66-87be-4c82-a9f5-ffefb7d01427}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_SEPAAMEG = "{0acfae7b-1ba1-403f-a0ef-86413a8143d5}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORAREVERB = "{a772ac44-cc2c-4bde-b0d1-d8f34b345fba}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_KNIPSPANDORA = "{024c35a7-02e4-4df8-85ab-3bb452163129}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_KNIPSPANNING = "{4a6bf237-aa37-478d-b3fd-4601305b2bd1}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_APPLEGLASSPANDORA = "{4baecaed-a265-4de8-b49f-3f5756e4e8ce}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORA = "{724adb89-eb8e-45be-ad9e-6152fc884d05}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_ENSONIQPANDORA = "{9b696646-d2ed-4536-b563-1139cb7b86f7}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_APPLEPURRPANNING = "{ce8faa56-14f7-4b8d-83f6-a95ca5179ab7}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORANAV = "{4b6efa88-f2d8-4d46-adcd-b4618bd2bfcd}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_SYNTHPANDORA = "{a4e268ae-9c48-442a-814b-d8d4b8f6d138}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_APPLEPURRPANDORANAV2 = "{68106c16-60e3-4548-bc55-30708237adf8}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_KNIPS = "{636ed7c6-fddc-4f00-9e03-f4d9a446f3b3}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_APPLEPURRFREQUENCY = "{d8d910f3-282f-466b-a97f-fc9ebf4d0944}";
const char *EVENTGUID_AUDIOCOMPASS_AUDICONS_TONEFREQUENCY = "{6a0aa2cd-ef74-4c1e-8ef4-7f498994e59f}";

#endif /* AUDIOCOMPASS_H */
