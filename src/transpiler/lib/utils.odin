package transpiler_lib
import "core:os"
import "core:fmt"
/*=========================
*Author: Marshall A Burns
*GitHub: @SchoolyB
*License: Apache 2.0 (See License For Details)
*
* File Description:
* This file contains helper procs and shit
*=========================*/


read_file ::proc(path:string) -> ( []byte, ^LibError){
    file, openError:= os.open(path, os.O_RDWR);
    defer os.close(file)
    if openError != nil{
        fmt.println("Failed to open file")
        return[]byte{}, new(LibError)
    }


    data, readSuccess:= os.read_entire_file(file);
    if readSuccess != true{
        fmt.println("Failed to read file")
        return []byte{},new(LibError)
    }

    return data, nil
}