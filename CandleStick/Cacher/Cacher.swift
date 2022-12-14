//
//  Cacher.swift
//  CandleStick
//
//  Created by Adel Aref on 10/10/2022.
//

import Foundation

/// `Cacher` is a super simple cross platform solution to persist `Cachable` types into the filesystem.
final public class Cacher {
    /// The path in the filesystem that will hold all the persisted items
    let destination: URL
    private let queue = OperationQueue()

    /// A type for the type of persistance options.
    ///
    /// - temporary: stores `Cachable` types into the temporary folder of the OS.
    /// - atFolder: stores `Cachable` types into a specific folder in the OS.
    public enum CacheDestination {
        /// Stores items in `NSTemporaryDirectory`
        case temporary
        /// Stores items at a specific location
        case atFolder(String)
    }

    // MARK: Initialization

    /// Initializes a newly created `Cacher` instance using the specified storage destination.
    /// *Note* If using `.atFolder(String)` make sure the destination is valid.
    ///
    /// - Parameter destination: path to the location where `Cacher` will persist its `Cachable` items.
    public init(destination: CacheDestination) {
        switch destination {
        case .temporary:
            self.destination = URL(fileURLWithPath: NSTemporaryDirectory())
        case .atFolder(let folder):
            let documentFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            self.destination = URL(fileURLWithPath: documentFolder).appendingPathComponent(folder, isDirectory: true)
        }

        try? FileManager.default
            .createDirectory(at: self.destination, withIntermediateDirectories: true, attributes: nil)
    }

    // MARK: Store a `Cachable` object in the directory selected by this `Cacher` instance.
    ///
    /// - Parameters:
    ///   - item: `Cachable` object to persist in the filesystem
    ///   - completion:callback invoked when the persistance finishes, it will either contain the `URL` or the `Error` .

    public func persist(item: Cachable, name: String = "", completion: @escaping (_
                url: URL?, _ error: Error?) -> Void) {
        var url: URL?
        var error: Error?
        // Create an operation to process the request.
        let operation = BlockOperation {
            do {
                url = try self.persist(data: item.transform(), at: self
                    .destination
                    .appendingPathComponent(name, isDirectory: false))
            } catch let persistError {
                error = persistError
            }
        }

        // Set the operation's completion block to call the request's completion handler.
        operation.completionBlock = {
            completion(url, error)
        }

        // Add the operation to the queue to start the work.
        queue.addOperation(operation)
    }

    /// Load cached data from the directory
    ///
    /// - Parameter fileName: of the cached data stored in the file system
    /// - Returns: the decoded cached data (if any)
    public func load<T: Cachable & Codable>(fileName: String) -> T? {

        let filePath = destination.appendingPathComponent("MagixResponse<\(fileName)>", isDirectory: false)
        guard
            let data = try? Data(contentsOf: filePath),
            let decoded = try? JSONDecoder().decode(T.self, from: data)
            else { return nil }
        return decoded
    }

    // MARK: Private

    private func persist(data: Data, at url: URL) throws -> URL {
        do {
            try data.write(to: url, options: [.atomicWrite])
            return url
        } catch let error {
            throw error
        }
    }
}

/// A type that can persist itself into the filesystem.
public protocol Cachable {
    /// The item's name in the filesystem.
    var fileName: String? { get set }

    /// Returns a `Data` encoded representation of the item.
    ///
    /// - Returns: `Data` representation of the item.
    func transform() -> Data
}

extension Cachable where Self: Codable {
    public func transform() -> Data {
        do {
            let encoded = try JSONEncoder().encode(self)
            return encoded
        } catch let error {
            fatalError("Unable to encode object: \(error)")
        }
    }
}
