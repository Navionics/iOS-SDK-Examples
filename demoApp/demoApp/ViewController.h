//
//  ViewController.h
//  demoApp
//
//  Copyright © 2017 Navionics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NavionicsMobileSDK/NavionicsMobileSDK.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutlet NMSMapView *mapView;
@property (retain, nonatomic) IBOutlet UIButton *plusButton;
@property (retain, nonatomic) IBOutlet UIButton *minusButton;
@property (retain, nonatomic) IBOutlet UIButton *circleButton;
@property (retain, nonatomic) IBOutlet UIButton *markerButton;
@property (retain, nonatomic) IBOutlet UIButton *polygonButton;
@property (retain, nonatomic) IBOutlet UIButton *polylineButton;
@property (retain, nonatomic) IBOutlet UIButton *gpsButton;
@property (retain, nonatomic) IBOutlet UIButton *downloadButton;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@end

