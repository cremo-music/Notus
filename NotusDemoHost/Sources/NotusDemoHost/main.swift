import Notus

print("\n**********************************\nWelcome to Notus!\n**********************************\n")

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
print("Reading and writing midi from Notus...")

writeExamplesToFile()
#else
print("Printing James Bond as Notus...\n\n")
do {
    let (music, _) = try james()
    print(music)
}
catch {
    print("Uha! Something terrible occurred.")
}

#endif
