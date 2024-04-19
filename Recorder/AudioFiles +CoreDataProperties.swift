//
//  Recordings+CoreDataProperties.swift
//  Recorder
//
//  Created by Prateek Bhardwaj on 18/04/24.
//
//

import Foundation
import CoreData


extension AudioFiles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AudioFiles> {
        return NSFetchRequest<AudioFiles>(entityName: "AudioFiles")
    }

    @NSManaged public var fileurl: URL

}

extension AudioFiles : Identifiable {

}
