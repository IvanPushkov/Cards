

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
     let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameStorage")
    private func cleanStorage(pairsAmount: Int){
        do{
            let results = try context.fetch(fetchRequest) as! [GameStorage]
            for result in results{
                if Int16(pairsAmount) == result.cardPairsAmount{
                    context.delete(result)
                }
            }
        } catch {
            print(error)
        }
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
}



