//
//  ShowMapview.h
//  Create_RouteMap_MkMapView
//
//  Created by Sonitek Mac on 02/06/16.
//  Copyright © 2016 Sonitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ShowMapview : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end
