//
//  FavoritesFoodManager.swift
//  DineDash
//
//  Created by Emre Yeşilyurt on 4.06.2024.
//

import UIKit
import CoreData

final class FavoritesFoodManager: CoreDataProtocol {
    static let shared = FavoritesFoodManager()
        typealias T = FavoriteFoods
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        func saveData(data: FavoriteFoods, completion: @escaping (Bool, CoreDataError) -> ()) {
            do {
                try self.context.save()
                completion(true, .noError)
            } catch {
                completion(false, .savingError)
            }
        }
        
        func fetchData(completion: @escaping ([FavoriteFoods]?, CoreDataError) -> ()) {
            let fetchRequest = NSFetchRequest<FavoriteFoods>(entityName: "FavoriteFoods")
            let sortByCreatedAt = NSSortDescriptor(key: "createdAt", ascending: false)
            fetchRequest.sortDescriptors = [sortByCreatedAt]
            do {
                let foods = try context.fetch(fetchRequest)
                if foods.count > 0 {
                    completion(foods, .noError)
                } else {
                    completion(nil, .dataError)
                }
            } catch {
                completion(nil, .fetchingError)
            }
        }
        
        func deleteData(id: Int, completion: @escaping (Bool, CoreDataError) -> ()) {
            let fetchRequest = NSFetchRequest<FavoriteFoods>(entityName: "FavoriteFoods")
            fetchRequest.predicate = NSPredicate(format: "foodId = %@", String(id))
            do {
                if let result = try context.fetch(fetchRequest).first {
                    context.delete(result)
                    try context.save()
                    completion(true, .noError)
                }
            } catch {
                completion(false, .removingError)
            }
        }
    
    
}


