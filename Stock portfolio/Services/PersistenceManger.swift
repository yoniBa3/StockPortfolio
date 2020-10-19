//
//  PersistenceManger.swift
//  Stock portfolio
//
//  Created by Yoni on 03/10/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import CoreData

class PersistenceManger{
    
    public static let shared = PersistenceManger()
    
    private init(){}
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: "Stock_portfolio")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    lazy var context = persistentContainer.viewContext

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: -CoreDataFetch
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T]{
        var result = [T]()
        let entityName = String(describing: objectType)
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do{
            if let fetchedObject = try context.fetch(fetchrequest) as? [T]{
                result = fetchedObject
            }
        }catch{
            print(error.localizedDescription)
        }
        
        return result
    }
}
