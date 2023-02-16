//
//  NSMutableArray+Sort.m
//  tayasui-test
//
//  Created by Lucien Brun on 15/02/2023.
//

#import "NSMutableArray+Sort.h"
#import "Recipe.h"

@class Recipe;

@implementation NSMutableArray (Sort)

/**
 Sorts an NSMutableArray of Recipe objects according to the following criteria, in the order indicated:
 - By descending score
 - By decreasing duration
 - By ascending alphabetical order of name
 
 The resulting array is sorted in the order indicated by the three criteria using the Quick Sort algorithm.
 */
- (void)sortRecipes {
    [self quickSortWithLeft:0 right:(int)self.count - 1];
}

/**
 Inserts a given recipe object at the end of the NSMutableArray object.
 
 @param recipe A Recipe object to be inserted into the NSMutableArray.
 */
- (void)insertRecipe:(Recipe *)recipe {
    [self addObject:recipe];
}

/**
 Sorts the recipes array using the QuickSort algorithm, known for its efficient average-case performance and is often used in applications where a fast sorting algorithm is required.
 
 This fonction recursively sorts the left sub-array and the right sub-array by calling itself with the left and right indices adjusted accordingly. This continues until all sub-arrays have been sorted.
 
 At the end of the sorting process, the entire recipes array will be sorted in descending order by score, descending order by duration, and ascending alphabetical order by name.
 
 @param left The leftmost index of the sub-array to sort.
 @param right The rightmost index of the sub-array to sort.
 */
- (void)quickSortWithLeft:(int)left right:(int)right {
    if (left >= right) {
        return;
    }
    
    int pivotIndex = [self partitionWithLeft:left right:right];
    
    [self quickSortWithLeft:left right:pivotIndex - 1];
    [self quickSortWithLeft:pivotIndex + 1 right:right];
}

/**
 Partitions a sub-array of the recipes array using the QuickSort algorithm.
 
 The function chooses the last element in the sub-array as the pivot. It then iterates over the sub-array from left to right-1. For each element in the sub-array, the function compares it with the pivot element. If the element should be on the left side of the partition, the function swaps it with the element at i+1, where i is the index of the last element on the left side of the partition. The function then increments i.
 
 After iterating over the sub-array, the function swaps the pivot element into its final position and returns the pivot index. The partitioned sub-array will have all elements with a score greater than or equal to the pivot score on the right side of the partition, and all elements with a score less than the pivot score on the left side of the partition. Within each side, the function also sorts elements by duration and name, as specified.
 
 @param left The leftmost index of the sub-array to partition.
 @param right The rightmost index of the sub-array to partition.
 @return The index of the pivot element after partitioning.
 */
- (int)partitionWithLeft:(int)left right:(int)right {
    Recipe *pivot = [self objectAtIndex:right];
    int lastLeftIndex = left - 1;
    
    for (int j = left; j < right; j++) {
        Recipe *recipe = [self objectAtIndex:j];
        // Compare the current recipe with the pivot recipe.
        // If the current recipe should be on the left side of the partition, swap it with the element at i+1.
        if (recipe.score > pivot.score
            || (recipe.score == pivot.score && recipe.duration > pivot.duration)
            || (recipe.score == pivot.score && recipe.duration == pivot.duration && [recipe.name compare:pivot.name] == NSOrderedAscending)) {
            lastLeftIndex++;
            [self exchangeObjectAtIndex:lastLeftIndex withObjectAtIndex:j];
        }
    }
    
    // Swap the pivot element into its final position and return the pivot index.
    [self exchangeObjectAtIndex:lastLeftIndex + 1 withObjectAtIndex:right];
    return lastLeftIndex + 1;
}

@end
