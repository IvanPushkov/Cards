

import Foundation
import CoreData

class CoreDataManager{
   
    static let instance = CoreDataManager()
    private init(){}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func makeFetchRequest(entityName:String) -> NSFetchRequest<NSFetchRequestResult>{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        return fetchRequest
    }
      func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getEntityForName(entityName: String) -> NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }

    func getValueFromStorage<T: NSManagedObject>(withEntytiName entity: String) -> [T] {
       do {
           let results = try context.fetch(makeFetchRequest(entityName: entity))
           return results as! [T]
       } catch {
           return [T]()
       }
   }
}



