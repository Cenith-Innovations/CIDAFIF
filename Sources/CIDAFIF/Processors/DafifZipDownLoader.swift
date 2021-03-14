// ********************** DafifZipDownLoader *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** DafifZipDownLoader *********************************


import SwiftUI
import Combine

@available(tvOS 13.0, *)
public class DafifDownloader: NSObject, ObservableObject, URLSessionDelegate, URLSessionDownloadDelegate, URLSessionTaskDelegate, BundleHelper {
    
    public static var shared = DafifDownloader()
    public var dataRequired: DafifDesired = .all
    
    public func downloadDafif(from dafifUrl: URL?) {
        DafifAPI.shared.errorDownloading = false
        guard let dafifLocation = dafifUrl else { return }
        let urlSession: URLSession = {
            return URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
        }()
        let request = URLRequest(url: dafifLocation)
        let task = urlSession.downloadTask(with: request)
        task.resume()
    }
    
    //Delegate functions
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let written = Double(totalBytesWritten)
        let total = Double(totalBytesExpectedToWrite)
        print("______________________________")
        print("Percent Downloaded: \(CGFloat(written/total))")
        DafifAPI.shared.downloadProgress = CGFloat(written/total)
    }

    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let fm = FileManager.default
        do  {
            let dafifLocUrl = getUrl(.dafifZipped)
            do {
                try fm.createDirectory(at: getUrl(.dafifCoreDataMain), withIntermediateDirectories: false, attributes: nil)
            } catch {
                deleteAllFiles(in: getUrl(.dafifCoreDataMain))
                print(error)
            }
            try FileManager.default.copyItem(at: location, to: dafifLocUrl)
        } catch {
            print(error)
        }
        DafifUnzipper.shared.unZipDafif(data: DafifDownloader.shared.dataRequired)
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            DafifAPI.shared.errorDownloading = true
        }
        print(error ?? "No error")
    }
}

