//
//  NSMutableArray+Sort.m
//  tayasui-test
//
//  Created by Lucien Brun on 15/02/2023.
//

#import "NSMutableArray+Sort.h"
#import "Recipe.h"

@implementation NSMutableArray (Sort)

- (void)sortRecipes {
    [self quickSortWithLeft:0 right:(int)self.count - 1];
}

- (void)insertRecipe:(Recipe *)recipe {
    [self addObject:recipe];
}

- (void)quickSortWithLeft:(int)left right:(int)right {
    if (left >= right) {
        return;
    }
    
    int pivot = [self partitionWithLeft:left right:right];
    [self quickSortWithLeft:left right:pivot - 1];
    [self quickSortWithLeft:pivot + 1 right:right];
}

- (int)partitionWithLeft:(int)left right:(int)right {
    Recipe *pivot = [self objectAtIndex:right];
    int i = left;
    
    for (int j = left; j < right; j++) {
        if ([self compareObject1:[self objectAtIndex:j] object2:pivot] == NSOrderedDescending) {
            [self exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
        }
    }
    
    [self exchangeObjectAtIndex:i withObjectAtIndex:right];
    return i;
}

- (NSComparisonResult)compareObject1:(id)object1 object2:(id)object2 {
    Recipe *recipe1 = (Recipe *)object1;
    Recipe *recipe2 = (Recipe *)object2;

    
    if (recipe1.score > recipe2.score) {
        return NSOrderedAscending;
    } else if (recipe1.score < recipe2.score) {
        return NSOrderedDescending;
    } else {
        if (recipe1.duration > recipe2.duration) {
            return NSOrderedAscending;
        } else if (recipe1.duration < recipe2.duration) {
            return NSOrderedDescending;
        } else {
            return [recipe1.name compare:recipe2.name];
        }
    }
}

@end
