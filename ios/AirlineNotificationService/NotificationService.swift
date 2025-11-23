import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    // Base URL must match your backend
    private let airlineImageBaseUrl = "https://imagedcs.abomis.com/api/airlineimage/"

    override func didReceive(_ request: UNNotificationRequest,
                             withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        guard let bestAttemptContent = bestAttemptContent else {
            contentHandler(request.content)
            return
        }

        let userInfo = bestAttemptContent.userInfo

        // Read airline code from payload: data["airline"]
        let airlineCode = userInfo["airline"] as? String

        guard let code = airlineCode, !code.isEmpty else {
            // No airline code -> just show the notification as-is
            contentHandler(bestAttemptContent)
            return
        }

        let imageUrlString = airlineImageBaseUrl + code
        guard let imageUrl = URL(string: imageUrlString) else {
            contentHandler(bestAttemptContent)
            return
        }

        // Download image
        let task = URLSession.shared.downloadTask(with: imageUrl) { [weak self] (tmpUrl, response, error) in
            guard let self = self,
                  let bestAttemptContent = self.bestAttemptContent else {
                contentHandler(request.content)
                return
            }

            if let error = error {
                NSLog("❌ Airline NSE: image download error: \(error)")
                contentHandler(bestAttemptContent)
                return
            }

            guard
                let tmpUrl = tmpUrl,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                NSLog("❌ Airline NSE: invalid HTTP response")
                contentHandler(bestAttemptContent)
                return
            }

            do {
                let fileManager = FileManager.default
                let mimeType = response?.mimeType ?? "image/png"
                let fileExtension = mimeType == "image/png" ? "png" : "jpg"
                let tmpDir = fileManager.temporaryDirectory
                let localUrl = tmpDir.appendingPathComponent("airline_\(code).\(fileExtension)")

                // Remove existing file if any
                try? fileManager.removeItem(at: localUrl)
                try fileManager.moveItem(at: tmpUrl, to: localUrl)

                let attachment = try UNNotificationAttachment(
                    identifier: "airline-logo",
                    url: localUrl,
                    options: nil
                )

                bestAttemptContent.attachments = [attachment]

                contentHandler(bestAttemptContent)

            } catch {
                NSLog("❌ Airline NSE: error handling image file: \(error)")
                contentHandler(bestAttemptContent)
            }
        }

        task.resume()
    }

    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        if let contentHandler = contentHandler,
           let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
