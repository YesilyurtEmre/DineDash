//
//  FavoritesFoodManager.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 4.06.2024.
//

import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func getFoods() -> [FavoriteFoods]
    func saveFood(foodId: Int32, name: String, price: String, image: Data)
    func deleteFood(foodId: Int32)
    func isFavorite(foodId: Int32) -> Bool
    func getFood(by foodId: Int) -> FavoriteFoods?
}

final class FavoritesFoodManager: CoreDataManagerProtocol {
    static let shared = FavoritesFoodManager()
    private init() {}
    
    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getFoods() -> [FavoriteFoods] {
        let fetchRequest: NSFetchRequest<FavoriteFoods> = FavoriteFoods.fetchRequest()
        let sortByCreatedAt = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortByCreatedAt]
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch foods: \(error)")
            return []
        }
    }
    
    func saveFood(foodId: Int32, name: String, price: String, image: Data) {
        let entity = FavoriteFoods(context: context)
        entity.foodId = foodId
        entity.name = name
        entity.price = price
        entity.image = image
        entity.createdAt = Date()
        
        do {
            try context.save()
        } catch {
            print("Failed to save food: \(error)")
        }
    }
    
    func deleteFood(foodId: Int32) {
        let request: NSFetchRequest<FavoriteFoods> = FavoriteFoods.fetchRequest()
        request.predicate = NSPredicate(format: "foodId == %d", foodId)
        
        do {
            let foods = try context.fetch(request)
            for food in foods {
                context.delete(food)
            }
            try context.save()
        } catch {
            print("Failed to delete food: \(error)")
        }
    }
    
    func isFavorite(foodId: Int32) -> Bool {
        let request: NSFetchRequest<FavoriteFoods> = FavoriteFoods.fetchRequest()
        request.predicate = NSPredicate(format: "foodId == %d", foodId)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Failed to check if food is favorite: \(error)")
            return false
        }
    }
    
    
    func getFood(by foodId: Int) -> FavoriteFoods? {
        let fetchRequest: NSFetchRequest<FavoriteFoods> = FavoriteFoods.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "foodId == %d", foodId)
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch food: \(error)")
            return nil
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FoodModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
}


