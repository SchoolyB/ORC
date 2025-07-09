package main

import "../src/transpiler"
import "core:fmt"


main :: proc() {
    using transpiler

    parsedFile, parseErr:=transpiler.parse_orc_file("test.orc"); if parseErr != nil do fmt.println("Failed to  transpile")
    fileValidated:= validate_orc_file(parsedFile)
    fmt.println(fileValidated)
    // fmt.println("DEBUG: Parsed File Content From Main: ", parsedFile)
}