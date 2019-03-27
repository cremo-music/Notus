import UIKit
import Notus

class LillePeterEdderkopViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var playButton: UIButton!    
    var delegate: PlayDelegate!
    
    var pickerData: [String] = ["None", "Staccato", "Legato",
                                "Crescendo (PPP to FFF)", "Diminuendo (FFF to PPP)", "Crescendo (relative)", "Diminuendo (relative)",
                                "Ritardando", "Accelerando"]
    
    @IBAction func playAction(_ sender: UIButton) {
        do {
            delegate.playAction(play: !sender.isSelected, button: sender, song: try lillePeterEdderkop())
            sender.isSelected = !sender.isSelected
        }
        catch let error {
            print("error: creating music sequence failed: \(error)")
        }
    }
    
    private func song() throws -> (Music, UserPatchMap) {
        let (music, upm) = try lillePeterEdderkop()
        
        switch picker.selectedRow(inComponent: 0) {
        case 0:
            return (music, upm)
        case 1:
            return (InterpretationConverters.staccato(music: music), upm)
        case 2:
            return (InterpretationConverters.legato(music: music), upm)
        case 3:
            return (InterpretationConverters.dynamicEvolutionPPPtoFFF(music: music), upm)
        case 4:
            return (InterpretationConverters.dynamicEvolutionFFFtoPPP(music: music), upm)
        case 5:
            return (InterpretationConverters.crescendo(music: music), upm)
        case 6:
            return (InterpretationConverters.diminuendo(music: music), upm)
        case 7:
            return (InterpretationConverters.ritardando(music: music), upm)
        case 8:
            return (InterpretationConverters.accelerando(music: music), upm)
        default:
            return (music, upm)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
