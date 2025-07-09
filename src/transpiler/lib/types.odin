package transpiler_lib


ParsedOrcFile::struct {
    path: string, //full path of the file
    fileName: string, //simply the name of the file
    odinStartBoundary: string, //@(Odin_Start)
    odinStartBoundaryExists: bool,
    odinCodeContent: OdinCodeContent,
    odinEndBoundary:string, //@(Odin_End)
    odinEndBoundaryExists: bool,

    orcOpenTag: string, //<Orc>
    containsOrcOpenTag: bool,
    orcComponents: [dynamic]OrcComponent,
    orcClosingTag: string, //</Orc>
    containsOrcCloseTage: bool
}

OdinCodeContent:: struct{
    rawContent: string,
    //Will most likely need to add more to this for futher parsing
}


OrcComponent::struct{
    name: string,
    rawContent: string, //the HTML inside the component as a single string, is then parsed to HTML_Element type
    attrubutes: map[string]string,
    hasOpeningTag:bool,
    hasClosingTag: bool,
    isValid: bool,
    htmlElements: [dynamic]HTML_Element,
    subOrcComponents: [dynamic]OrcComponent,
}

HTML_Element :: struct {
    tagName: string,
    attributes: [dynamic]map[string]string, //An element can have multiple attributes e.g class, id, href, etc...
    content: map[string]string, //The contnent to display in this element
    hasOpeningTag, hasClosingTag: bool,
    parentElements:[dynamic]HTML_Element,
    childElements:[dynamic]HTML_Element
}