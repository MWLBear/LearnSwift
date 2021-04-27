
import UIKit
import AVFoundation

public protocol MusicButtonDelegate: class {
  func touchesEnded(_ sender: MusicButton)
}

public final class MusicButton: UIButton {
  // MARK: Properties
  public var musicGenre: MusicGenre = .other {
    didSet {
      backgroundColor = musicGenre.backgroundColor
      setTitle(musicGenre.rawValue.uppercased(), for: .normal)
      titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    }
  }

  public weak var delegate: MusicButtonDelegate?

  // MARK: Initializers
  override public init(frame: CGRect) {
    super.init(frame: frame)
    layer.masksToBounds = true
    setTitleColor(.white, for: .normal)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: Layouts
  override public func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.width / 5
  }

  // MARK: AVAudioPlayer
  @objc public func makeAudioPlayer() -> AVAudioPlayer? {
    guard let url = Bundle.main.url(
      forResource: musicGenre.rawValue,
      withExtension: "m4a") else { return nil }
    do {
      let audioPlayer = try AVAudioPlayer(contentsOf: url)
      audioPlayer.numberOfLoops = -1
      audioPlayer.prepareToPlay()
      return audioPlayer
    } catch {
      print("Audio Player Error:", error)
      return nil
    }
  }

  // MARK: Actions
  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    delegate?.touchesEnded(self)
  }
}
