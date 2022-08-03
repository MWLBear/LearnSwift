
import UIKit

// MARK: - SAVE, LOAD AND DELETE IMAGE FILE
extension UIImage {
  static var minsize = CGSize(width: 300, height: 200)
  static var maxSize = CGSize(width: 1000, height: 1500)

  func save(to filename: String? = nil) -> String {
    // first resize large images
    let image = resizeLargeImage()
    let path: String
    if let filename = filename {
      path = filename
    } else {
      path = UUID().uuidString
    }
    if let url = FileManager.documentURL?.appendingPathComponent(path) {
      do {
        try image.pngData()?.write(to: url)
      } catch {
        print(error.localizedDescription)
      }
    }
    return path
  }

  static func load(uuidString: String) -> UIImage? {
    guard uuidString != "none" else { return nil }
    if let url = FileManager.documentURL?.appendingPathComponent(uuidString),
      let imageData = try? Data(contentsOf: url) {
        return UIImage(data: imageData)
    } else {
      return nil
    }
  }

  static func remove(name: String?) {
    if let name = name,
      let url = FileManager.documentURL?.appendingPathComponent(name) {
        try? FileManager.default.removeItem(at: url)
    }
  }
}

// MARK: - GET IMAGE SIZE
extension UIImage {
  func initialSize() -> CGSize {
    var width = Settings.defaultElementSize.width
    var height = Settings.defaultElementSize.height

    if self.size.width >= self.size.height {
      width = max(Self.minsize.width, width)
      width = min(Self.maxSize.width, width)
      height = self.size.height * (width / self.size.width)
    } else {
      height = max(Self.minsize.height, height)
      height = min(Self.maxSize.height, height)
      width = self.size.width * (height / self.size.height)
    }
    return CGSize(width: width, height: height)
  }

  static func imageSize(named imageName: String) -> CGSize {
    if let image = UIImage(named: imageName) {
      return image.initialSize()
    }
    return .zero
  }
}

// MARK: - RESIZE IMAGE
extension UIImage {
  func resizeLargeImage() -> UIImage {
    let defaultSize: CGFloat = 1000
    if size.width <= defaultSize ||
      size.height <= defaultSize { return self }

    let scale: CGFloat
    if size.width >= size.height {
      scale = defaultSize / size.width
    } else {
      scale = defaultSize / size.height
    }
    let newSize = CGSize(
      width: size.width * scale,
      height: size.height * scale)
    return resize(to: newSize)
  }

  func resize(to size: CGSize) -> UIImage {
    // UIGraphicsImageRenderer sets scale to device's screen scale
    // change the scale to 1 to get the real image size
    let format = UIGraphicsImageRendererFormat()
    format.scale = 1
    return UIGraphicsImageRenderer(size: size, format: format).image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }
}
