//
//  ViewController.m
//  DrumKit
//
//  Created by Billy Rey Caballero on 3/5/17.
//  Copyright © 2017 alcoderithm. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()

@property (assign, nonatomic) SystemSoundID soundBeat1;
@property (assign, nonatomic) SystemSoundID soundBeat2;
@property (assign, nonatomic) SystemSoundID soundBeat3;
@property (assign, nonatomic) SystemSoundID soundBeat4;
@property (strong, nonatomic) AVAudioPlayer *longSoundPlay;

@property (weak, nonatomic) IBOutlet UIButton *startSoundButton;
@property (weak, nonatomic) IBOutlet UIButton *stopSoundButton;

@property (assign, nonatomic) BOOL goodBeat1;
@property (assign, nonatomic) BOOL goodBeat2;
@property (assign, nonatomic) BOOL goodBeat3;
@property (assign, nonatomic) BOOL goodBeat4;
@property (assign, nonatomic) BOOL goodSound;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *beat1 = [[NSBundle mainBundle] pathForResource:@"beat1" ofType:@"aiff"];
    NSURL *url1 = [NSURL fileURLWithPath:beat1];
    
    NSString *beat2 = [[NSBundle mainBundle] pathForResource:@"beat2" ofType:@"aiff"];
    NSURL *url2 = [NSURL fileURLWithPath:beat2];
    
    NSString *beat3 = [[NSBundle mainBundle] pathForResource:@"beat3" ofType:@"aiff"];
    NSURL *url3 = [NSURL fileURLWithPath:beat3];
    
    NSString *beat4 = [[NSBundle mainBundle] pathForResource:@"beat4" ofType:@"aiff"];
    NSURL *url4 = [NSURL fileURLWithPath:beat4];
    
    NSString *longSound = [[NSBundle mainBundle] pathForResource:@"longsound" ofType:@"wav"];
    NSURL *urlSound = [NSURL fileURLWithPath:longSound];
    
    OSStatus statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef) url1, &_soundBeat1);
    
    if (statusReport == kAudioServicesNoError) {
        self.goodBeat1 = YES;
    } else {
        self.goodBeat1 = NO;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Coudn't load soundBeat1" message:@"soundBeat1 problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController: alert animated: YES completion: nil];
    }
    
    statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef) url2, &_soundBeat2);
    
    if (statusReport == kAudioServicesNoError) {
        self.goodBeat2 = YES;
    } else {
        self.goodBeat2 = NO;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Coudn't load soundBeat2" message:@"soundBeat2 problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController: alert animated: YES completion: nil];
    }

    statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef) url3, &_soundBeat3);
    
    if (statusReport == kAudioServicesNoError) {
        self.goodBeat3 = YES;
    } else {
        self.goodBeat3 = NO;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Coudn't load soundBeat3" message:@"soundBeat3 problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController: alert animated: YES completion: nil];
    }

    statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef) url4, &_soundBeat4);
    
    if (statusReport == kAudioServicesNoError) {
        self.goodBeat4 = YES;
    } else {
        self.goodBeat4 = NO;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Coudn't load soundBeat4" message:@"soundBeat4 problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController: alert animated: YES completion: nil];
    }
    
    NSError *err;
    
    self.longSoundPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSound error:&err];
    if (!self.longSoundPlay) {
        self.goodSound = NO;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Coudn't load wav" message:[err localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController: alert animated: YES completion: nil];
    } else {
        self.goodSound = YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)playBeat1:(id)sender {
    if(self.goodBeat1) {
        AudioServicesPlaySystemSound(self.soundBeat1);
    }
}

- (IBAction)playBeat2:(id)sender {
    if(self.goodBeat2) {
        AudioServicesPlaySystemSound(self.soundBeat2);
    }
}

- (IBAction)playBeat3:(id)sender {
    if(self.goodBeat3) {
        AudioServicesPlaySystemSound(self.soundBeat3);
    }
}

- (IBAction)playBeat4:(id)sender {
    if(self.goodBeat4) {
        AudioServicesPlaySystemSound(self.soundBeat4);
    }
}

- (IBAction)playLongSound:(id)sender {
    if(self.goodSound) {
        [self.longSoundPlay play];
    }
    [self.startSoundButton setTitleColor:[UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.0] forState:UIControlStateNormal];
    [self.stopSoundButton setTitleColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
    self.startSoundButton.enabled = NO;
    self.stopSoundButton.enabled = YES;
}

- (IBAction)stopLongSound:(id)sender {
    if(self.goodSound) {
        [self.longSoundPlay stop];
    }
    self.startSoundButton.enabled = YES;
    [self.stopSoundButton setTitleColor:[UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.0f] forState:UIControlStateNormal];
    [self.startSoundButton setTitleColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
    self.stopSoundButton.enabled = NO;
}

- (void) dealloc {
    if (self.goodBeat1) {
        AudioServicesDisposeSystemSoundID(self.soundBeat1);
    }
    
    if (self.goodBeat2) {
        AudioServicesDisposeSystemSoundID(self.soundBeat2);
    }

    if (self.goodBeat3) {
        AudioServicesDisposeSystemSoundID(self.soundBeat2);
    }
    
    if (self.goodBeat4) {
        AudioServicesDisposeSystemSoundID(self.soundBeat4);
    }
}




@end
