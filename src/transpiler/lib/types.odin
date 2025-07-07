package transpiler_lib


ParsedOrcFile::struct {
    path: string, //full path of the file
    fileName: string, //simply the name of the file
    odinStartBoundary: string, //@(Odin_Start)
    odinStartBoundaryExists: bool,
    odinCodeContent: OdinCodeContent,
    odinEndBoundary:string, //@(Odin_End)
    odinEndBoundaryExists: bool,

    orcOpenTag: string, //<orc>
    containsOrcOpenTag: bool,
    orcComponents: [dynamic]OrcComponent,
    orcClosingTag: string, //</orc>
    containsOrcCloseTage: bool
}

OdinCodeContent:: struct{
    rawContent: string,
    //Will most likely need to add more to this for futher parsing
}

OrcComponent::struct{
    name: string,
    attrubutes: map[string]string,
    content: string,
    hasOpeningTag:bool,
    hasClosingTag: bool,
    isValid: bool,
    subOrcComponents: [dynamic]OrcComponent
}






