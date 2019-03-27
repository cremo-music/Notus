import UIKit
import Notus

protocol PlayDelegate {
    func playAction(play: Bool, button: UIButton, song: (Music, UserPatchMap))
}

class ViewController: UIViewController, PlayDelegate {
    
    var playerManager = PlayerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writeExamplesToFile()
    }
    
    func playAction(play: Bool, button: UIButton, song: (Music, UserPatchMap)) {
        do {
            if !play {
                playerManager.stop()
                button.isSelected = false
            } else {
                try playerManager.play(song: song, didFinish:{
                    self.updatePlayButton(isPlaying: false, button: button)
                })
                updatePlayButton(isPlaying: true, button: button)
            }
        }
        catch let error {
            print("error: creating music sequence failed: \(error)")
        }
    }
    
    private func updatePlayButton(isPlaying: Bool, button: UIButton) {
        DispatchQueue.main.async{
            button.isSelected = isPlaying
            if isPlaying {
                button.setTitle("STOP", for: UIControl.State.normal)
            }
            else {
                button.setTitle("PLAY", for: UIControl.State.normal)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "EdderkopSegue":
            let vc = segue.destination as! LillePeterEdderkopViewController
            vc.delegate = self
        case "CanineSegue":
            let vc = segue.destination as! CanineViewController
            vc.delegate = self
        case "FrereJacquesSegue":
            let vc = segue.destination as! FrereJacquesController
            vc.delegate = self
        case "ChameleonSegue":
            let vc = segue.destination as! ChameleonViewController
            vc.delegate = self
        default:
            return
        }
    }
}

