package transpiler_lib
import "core:strings"

LibErrorType::enum{
    NO_ERROR = 0,
    CANNOT_OPEN_DIR,
    CANNOT_OPEN_FILE,
    CANNOT_READ_FILE,
    UNKNOWN,  //do something better
}

LibError :: struct{
    type: string,
    message:string
}

TranspilerErrorType::enum{
NO_ERR = 0,
CFF, //cannot find file
CRF, //cannot read file
INVLD_FS, //invalid structure
INVLD_ODIN_CODE, //invalid
INVLD_ORC_CODE, //invalid
FTP, //failed to parse
FTT, //failed to transpile
FCVF, //failed to creat validation file
FTV //failed to validate

}

TranspilerErrorMessage:=[TranspilerErrorType]string {
    .NO_ERR = "No Transpiler Error ",
    .CFF = "Cannot find .Orc file",
    .CRF = "Cannot read Orc file",
    .INVLD_FS = "",
    .INVLD_ODIN_CODE = "Invalid Odin code found in .orc file",
    .INVLD_ORC_CODE = "Invalid Orc code found in .orc file",
    .FTP = "Failed to parse .orc file",
    .FTT = "Failed to transpile .orc file into valid Odin code",
    .FCVF = "",
    .FTV = ""
}

TranspilerError :: struct {
    type: TranspilerErrorType,
    TranspilerErrorMessage: string
}

make_error ::proc(type:TranspilerErrorType, msg:string) -> ^TranspilerError{
    error:= new(TranspilerError)
    error.type = type
    error.TranspilerErrorMessage = strings.clone(msg)

    return error
}
