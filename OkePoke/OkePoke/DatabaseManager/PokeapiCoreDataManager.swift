//
//  PokeapiCoreDataManager.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 29.11.22.
//

import UIKit
import CoreData


class PokeapiCoreDataManager {
    let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let fetchResponseRequest: NSFetchRequest<ResponseData> = ResponseData.fetchRequest()
    // I ran out of time :(
}
