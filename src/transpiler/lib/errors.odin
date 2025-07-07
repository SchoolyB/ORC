package transpiler_lib

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
    NO_ERROR = 0,
    INVALID_ODIN_CODE,
    INVALID_ORC_CODE,
    FAILED_TO_PARSE,
    FAILED_TO_TRANSPILE
}

TranspilerErrorMessage:=[TranspilerErrorType]string {
    .NO_ERROR = "No Transpiler Error ",
    .INVALID_ODIN_CODE = "Invalid Odin code found in .orc file",
    .INVALID_ORC_CODE = "Invalid Orc code found in .orc file",
    .FAILED_TO_PARSE = "Failed tp parse .orc file",
    .FAILED_TO_TRANSPILE = "Failed to transpile .orc file into valid Odin code"
}

TranspilerError :: struct {
    type: TranspilerErrorType,
    TranspilerErrorMessage: string
}

make_error ::proc() -> ^TranspilerError{
    return new(TranspilerError)
}
