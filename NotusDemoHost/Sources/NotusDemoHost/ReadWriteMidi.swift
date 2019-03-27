import Foundation
import Notus

func writeExamplesToFile() {
    do {
        let temporaryRootURL = FileManager.default.urls(for: .documentDirectory,
                                                             in: .userDomainMask).first!
        let temporaryDirectoryURL = temporaryRootURL.appendingPathComponent("Notus")
        
        try FileManager.default.createDirectory(at: temporaryDirectoryURL, withIntermediateDirectories: true)
        
        var (music, upm) = try lillePeterEdderkopTranspose()
        let edderkopUrl = temporaryDirectoryURL.appendingPathComponent("lillePeterEdderkop.mid")
        try music.toMidiFile(userPatchMap: upm, fileUrl: edderkopUrl)
        
        (music, upm) = try frereJacques()
        let frereJacquesUrl = temporaryDirectoryURL.appendingPathComponent("frereJacques.mid")
        try music.toMidiFile(userPatchMap: upm, fileUrl: frereJacquesUrl)
        
        (music, upm) = try chameleon()
        let chameleonUrl = temporaryDirectoryURL.appendingPathComponent("chameleon.mid")
        try music.toMidiFile(userPatchMap: upm, fileUrl: chameleonUrl)
        
        (music, upm) = try drumsolo()
        let drumsoloUrl = temporaryDirectoryURL.appendingPathComponent("drumsolo.mid")
        try music.toMidiFile(userPatchMap: upm, fileUrl: drumsoloUrl)
        
        (music, upm) = try counterpoint()
        let counterpointUrl = temporaryDirectoryURL.appendingPathComponent("counterpoint.mid")
        try music.toMidiFile(userPatchMap: upm, fileUrl: counterpointUrl)
        
        (music, upm) = try triol()
        let triolUrl = temporaryDirectoryURL.appendingPathComponent("triol.mid")
        try music.toMidiFile(userPatchMap: upm, fileUrl: triolUrl)
        
        (music, upm) =  try canine()
        let canineUrl = temporaryDirectoryURL.appendingPathComponent("canine.mid")
        try music.toMidiFile(userPatchMap: upm, fileUrl: canineUrl)
        
        (music, upm) = try james()
        let jamesUrl = temporaryDirectoryURL.appendingPathComponent("james.mid")
        try music.toMidiFile(userPatchMap: upm, fileUrl: jamesUrl)
        
        var filePathUrl = temporaryDirectoryURL.appendingPathComponent("lillePeterEdderkopReloaded.mid")
        (music, upm) = try importFromMidi(fileUrl: edderkopUrl)
        try music.toMidiFile(userPatchMap: upm, fileUrl: filePathUrl)
        
        filePathUrl = temporaryDirectoryURL.appendingPathComponent("frereJacquesReloaded.mid")
        (music, upm) = try importFromMidi(fileUrl: frereJacquesUrl)
        try music.toMidiFile(userPatchMap: upm, fileUrl: filePathUrl)
        
        filePathUrl = temporaryDirectoryURL.appendingPathComponent("chameleonReloaded.mid")
        (music, upm) = try importFromMidi(fileUrl: chameleonUrl)
        try music.toMidiFile(userPatchMap: upm, fileUrl: filePathUrl)
        
        filePathUrl = temporaryDirectoryURL.appendingPathComponent("drumsoloReloaded.mid")
        (music, upm) = try importFromMidi(fileUrl: drumsoloUrl)
        try music.toMidiFile(userPatchMap: upm, fileUrl: filePathUrl)
        
        filePathUrl = temporaryDirectoryURL.appendingPathComponent("counterpointReloaded.mid")
        (music, upm) = try importFromMidi(fileUrl: counterpointUrl)
        try music.toMidiFile(userPatchMap: upm, fileUrl: filePathUrl)
        
        filePathUrl = temporaryDirectoryURL.appendingPathComponent("triolReloaded.mid")
        (music, upm) = try importFromMidi(fileUrl: triolUrl)
        try music.toMidiFile(userPatchMap: upm, fileUrl: filePathUrl)
        
        filePathUrl = temporaryDirectoryURL.appendingPathComponent("canineReloaded.mid")
        (music, upm) = try importFromMidi(fileUrl: canineUrl)
        try music.toMidiFile(userPatchMap: upm, fileUrl: filePathUrl)
        
        filePathUrl = temporaryDirectoryURL.appendingPathComponent("jamesReloaded.mid")
        (music, upm) = try importFromMidi(fileUrl: jamesUrl)
        try music.toMidiFile(userPatchMap: upm, fileUrl: filePathUrl)
        
        print("Stored Notus music as MIDI file here: \(temporaryDirectoryURL)")
        
    } catch let error {
        print("error: Failed to generate example: \(error))")
    }
}
