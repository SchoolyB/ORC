package transpiler
import L"./lib"
import "core:os"
import "core:strings"
import "core:fmt"
import "core:c/libc"
/*=========================
*Author: Marshall A Burns
*GitHub: @SchoolyB
*License: Apache 2.0 (See License For Details)
*
* File Description:
* This file contains the parsing logic for .orc files
*=========================*/


//Parse the content of an ORC file and appends to a ^L.ParsedOrcFile struct
@(require_results)
parse_orc_file:: proc(path:string) -> (^L.ParsedOrcFile, ^L.TranspilerError){
    using fmt
    using L

    data, readErr:= read_file(path); if readErr!= nil do return nil, make_error(.CRF, tprintf("Cannot read file %s", path))
    parsedOrcFile:= new(ParsedOrcFile)
    parsedOrcFile.path = path
    splitPath:= strings.split(path, ".orc")
    defer delete(splitPath)

    //FIXME: This wont work for very long need to improve logic
    parsedOrcFile.fileName = splitPath[0]

    content:= string(data)

    // Parse the Odin section
    odinStartIndex := strings.index(content, ODIN_START_TAG)
    odinEndIndex := strings.index(content, ODIN_END_TAG)

    if odinStartIndex >= 0 {
        parsedOrcFile.odinStartBoundaryExists = true
        parsedOrcFile.odinStartBoundary = ODIN_START_TAG

        if odinEndIndex >= 0 {
            parsedOrcFile.odinEndBoundaryExists = true
            parsedOrcFile.odinEndBoundary = ODIN_END_TAG

            // Extract Odin code content between boundaries
            startOffset := odinStartIndex + len(ODIN_START_TAG)
            odinContent := strings.trim_space(content[startOffset:odinEndIndex])
            parsedOrcFile.odinCodeContent.rawContent = strings.clone(odinContent)
        } else do return parsedOrcFile, make_error(.INVLD_FS, tprintf("Invalid file structure detected in file: %s", parsedOrcFile.fileName))
    }

    // Parse ORC section
    orcStartIndex := strings.index(content, ORC_OPEN_TAG)
    orcCloseIndex := strings.index(content, ORC_CLOSE_TAG)

    if orcStartIndex >= 0 {
        parsedOrcFile.containsOrcOpenTag = true

        // Extract the complete opening tag line (e.g., <Orc = "signUp">)
        lineStart := orcStartIndex
        for lineStart > 0 && content[lineStart-1] != '\n' {
            lineStart -= 1
        }

        lineEnd := orcStartIndex
        for lineEnd < len(content) && content[lineEnd] != '\n' {
            lineEnd += 1
        }

        fullOpeningTag := strings.trim_space(content[lineStart:lineEnd])
        parsedOrcFile.orcOpenTag = strings.clone(fullOpeningTag)

        if orcCloseIndex >= 0 {
            parsedOrcFile.containsOrcCloseTage = true
            parsedOrcFile.orcClosingTag = ORC_CLOSE_TAG

            // Extract ORC content
            startOffset := orcStartIndex + len(ORC_OPEN_TAG)
            orcContent := strings.trim_space(content[startOffset:orcCloseIndex])

            // Parse ORC components from content
            parse_orc_components(orcContent, &parsedOrcFile.orcComponents)
        }
    }

    return parsedOrcFile, nil
}

parse_orc_components :: proc(content: string, components: ^[dynamic]L.OrcComponent) {
    lines := strings.split(content, "\n")

    for line in lines {
        trimmed := strings.trim_space(line)
        if len(trimmed) > 0 && !strings.has_prefix(trimmed, "//") { //if not comment out with //
            component := L.OrcComponent{
                isValid = true,
            }

            //Get the component name
            component.name = strings.trim_right(lines[0],">")
            append(components, component)
        }
    }
}


parse_html::proc(orcComponent:L.OrcComponent) -> L.OrcComponent{




}

// Validate the parsed ORC file for syntax and structural errors
@(require_results)
validate_orc_file :: proc(parsedFile: ^L.ParsedOrcFile) -> ^L.TranspilerError {
    using L

    // Validate basic structure
    if !parsedFile.odinStartBoundaryExists {
        return make_error(.INVLD_FS,"Missing Odin start boundary '@(Odin_Start)'")
    }

    if !parsedFile.odinEndBoundaryExists {
        return make_error(.INVLD_FS,"Missing Odin end boundary '@(Odin_End)'")
    }

    if !parsedFile.containsOrcOpenTag {
        return make_error(.INVLD_FS,"Missing ORC open tag '<Orc>'")
    }

    if !parsedFile.containsOrcCloseTage {
        return make_error(.INVLD_FS,"Missing ORC close tag '</Orc>'")
    }

    // Validate Odin code syntax
    if len(parsedFile.odinCodeContent.rawContent) > 0 {
        if err := validate_odin_syntax(parsedFile); err != nil {
            return err
        }
    }

    // Validate ORC components
    if err := validate_orc_components(&parsedFile.orcComponents); err != nil {
        return err
    }

    return nil
}

// Validate Odin code syntax by attempting to compile it
@(require_results)
validate_odin_syntax :: proc(parsedFile: ^L.ParsedOrcFile) -> ^L.TranspilerError {
    using L

    odinCode:=  parsedFile.odinCodeContent.rawContent
    tempFilePath := fmt.tprintf("output/output_%s.odin", parsedFile.fileName)

       // Wrap the Odin code
       wrappedCode := fmt.aprintf("package %s\n\n%s",parsedFile.fileName, odinCode)

       libc.system(strings.clone_to_cstring("mkdir output"))

       // Write to temp file
       if !os.write_entire_file(tempFilePath, transmute([]u8)wrappedCode) {
           return make_error(.FCVF,"Failed to create temporary validation file")
       }

       //Try to compile Odin code
       cmd := fmt.aprintf("odin check %s -file", tempFilePath)
       defer delete(cmd)

       cmdAsCString := strings.clone_to_cstring(cmd)
       defer delete(cmdAsCString)

       result := libc.system(cmdAsCString)
       if result != 0 {
           fmt.println("Failed to validate Odin Code")
           return make_error(.FTV, "Odin code validation failed")
       }

       fmt.printfln("Successfully validated Odin Code in file: %s", parsedFile.fileName)
       return nil
}

// Validate ORC components for proper structure
@(require_results)
validate_orc_components :: proc(components: ^[dynamic]L.OrcComponent) -> ^L.TranspilerError {
    using L

    for component in components {
        if len(component.name) == 0 {
            return make_error(.INVLD_FS, "Orc Components must have names")
        }

        if strings.has_prefix(component.name, "<") && !strings.has_suffix(component.name, ">") {
            return make_error(.FTV,"Invalid ORC tag format")
        }

    }
    return nil
}

