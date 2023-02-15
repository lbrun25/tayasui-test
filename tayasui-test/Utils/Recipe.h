//
//  Recipe.h
//  tayasui-test
//
//  Created by Lucien Brun on 15/02/2023.
//

#ifndef Recipe_h
#define Recipe_h


#import <UIKit/UIKit.h>

@interface Recipe : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *ingredients;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic, copy) NSString *directions;
@property (nonatomic) uint8_t score;

- (instancetype)initWithName:(NSString *)name
                       image:(UIImage *)image
                 ingredients:(NSString *)ingredients
                    duration:(NSTimeInterval)duration
                   directions:(NSString *)directions
                        score:(uint8_t)score;

@end


#endif /* Recipe_h */
