//
//  CRTSerialization.h
//  CartographerKit
//
//  Created by Iain Holmes on 11/10/2014.
//  Copyright (c) 2014 False Victories. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `CRTSerialization` is a class that helps in parsing the JSON file format that the app
 Cartographer uses.
*/

@class MKShape;
@interface CRTSerialization : NSObject

/**
 * The JSON key for the features array
 */
extern NSString * const kCRTJSONFeaturesName;

/**
 * The JSON key for the feature type
 */
extern NSString * const kCRTJSONTypeName;
/**
 * The JSON key for the coordinate dictionary
 */
extern NSString * const kCRTJSONCoordinateName;
/**
 * The JSON key for the latitude float
 */
extern NSString * const kCRTJSONLatitudeName;
/**
 * The JSON key for the longitude float
 */
extern NSString * const kCRTJSONLongitudeName;
/**
 * The JSON key for the array of coordinates that represent the points in a polygon or polyline
 */
extern NSString * const kCRTJSONPointsName;
/**
 * The JSON key for the circle's radius
 */
extern NSString * const kCRTJSONRadiusName;
/**
 * The JSON key for the region dictionary
 */
extern NSString * const kCRTJSONRegionName;
/**
 * The JSON key for the region dictionary's latitude delta
 */
extern NSString * const kCRTJSONLatitudeDeltaName;
/**
 * The JSON key for the region dictionary's longitude delta
 */
extern NSString * const kCRTJSONLongitudeDeltaName;
/**
 * The JSON key for the pin color of an annotation
 */
extern NSString * const kCRTJSONPinColorName;
/**
 * The JSON key for the stroke color of a shape
 */
extern NSString * const kCRTJSONStrokeColorName;
/**
 * The JSON key for the fill color of a shape
 */
extern NSString * const kCRTJSONFillColorName;
/** 
 * The JSON key for the title of the shape.
 */
extern NSString * const kCRTJSONTitleName;
/**
 * The JSON key for the subtitle of the shape
 */
extern NSString * const kCRTJSONSubtitleName;

/**
 * The value of the kCRTJSONTypeName key when the shape is an annotation
 */
extern NSString * const kCRTJSONTypeAnnotationName;
/**
 * The value of the kCRTJSONTypeName key when the shape is a polyline
 */
extern NSString * const kCRTJSONTypePolylineName;
/**
 * The value of the kCRTJSONTypeName key when the shape is a polygon
 */
extern NSString * const kCRTJSONTypePolygonName;
/**
 * The value of the kCRTJSONTypeName key when the shape is a circle
 */
extern NSString * const kCRTJSONTypeCircleName;

/**
 * The value of the kCRTJSONPinColorName key for red pins
 */
extern NSString * const kCRTJSONPinColorRedName;
/**
 * The value of the kCRTJSONPinColorName key for green pins
 */
extern NSString * const kCRTJSONPinColorGreenName;
/**
 * The value of the kCRTJSONPinColorName key for purple pins
 */
extern NSString * const kCRTJSONPinColorPurpleName;

/**
 Enumerates through the various shapes contained in the JSON dictionary

 @param jsonDict The JSON dictionary parsed from the file format
 @param block A block that takes two arguments. The first is the `MKShape` representing the shape, the second is an `NSDictionary` containing the extra properties that Cartographer has set for this shape
*/

+ (void)enumerateShapesFromJSON:(NSDictionary *)jsonDict
                     usingBlock:(void (^)(MKShape *shape, NSDictionary *properties))block;

@end
