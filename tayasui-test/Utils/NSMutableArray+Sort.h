//
//  NSMutableArray+Sort.h
//  tayasui-test
//
//  Created by Lucien Brun on 15/02/2023.
//

#ifndef NSMutableArray_Sort_h
#define NSMutableArray_Sort_h


#import <Foundation/Foundation.h>

@class Recipe;

@interface NSMutableArray (Sort)

- (void)sortRecipes;
- (void)insertRecipe:(Recipe *)recipe;

@end


#endif /* NSMutableArray_Sort_h */
