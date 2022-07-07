import Glibc

// Reads input file for given day and returns it as a list of lines.
public func readInput(day: String, filename: String) -> [String] {
    let BUFSIZE = 1024
    var content = ""
    if let fp = fopen("Sources/\(day)/\(filename)", "r") {
        var buf = [CChar](repeating:CChar(0), count:BUFSIZE)
        while fgets(&buf, Int32(BUFSIZE), fp) != nil {
            content += String(cString: buf)
        }
        fclose(fp)
    }
    return content.split(whereSeparator: \.isNewline).map(String.init)
}
