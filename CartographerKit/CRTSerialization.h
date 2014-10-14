//
//  CRTSerialization.h
//  CartographerKit
//
//  Created by Iain Holmes on 11/10/2014.
//  Copyright (c) 2014 False Victories. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKShape;
@interface CRTSerialization : NSObject

extern NSString * const kCRTJSONFeaturesName;

extern NSString * const kCRTJSONTypeName;
extern NSString * const kCRTJSONCoordinateName;
extern NSString * const kCRTJSONLatitudeName;
extern NSString * const kCRTJSONLongitudeName;
extern NSString * const kCRTJSONPointsName;
extern NSString * const kCRTJSONRadiusName;
extern NSString * const kCRTJSONRegionName;
extern NSString * const kCRTJSONLatitudeDeltaName;
extern NSString * const kCRTJSONLongitudeDeltaName;
extern NSString * const kCRTJSONPinColorName;
extern NSString * const kCRTJSONStrokeColorName;
extern NSString * const kCRTJSONFillColorName;
extern NSString * const kCRTJSONTitleName;
extern NSString * const kCRTJSONSubtitleName;

extern NSString * const kCRTJSONTypeAnnotationName;
extern NSString * const kCRTJSONTypePolylineName;
extern NSString * const kCRTJSONTypePolygonName;
extern NSString * const kCRTJSONTypeCircleName;

extern NSString * const kCRTJSONPinColorRedName;
extern NSString * const kCRTJSONPinColorGreenName;
extern NSString * const kCRTJSONPinColorPurpleName;

+ (void)enumerateShapesFromJSON:(NSDictionary *)jsonDict
                     usingBlock:(void (^)(MKShape *shape, NSDictionary *properties))block;

@end
