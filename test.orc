@(Odin_Start)
import "core:fmt"

main :: proc(){
 //Note: For this to be valid Odin code in the is section a 'main()' must exist
}

some_other_proc :: proc(){
    fmt.println("Hello, World")
}

Person :: struct {
    name: string,
    age: i64,
    location: Location
}

Location :: struct {
    street_number: i64,
    city: string,
    state: string,
    zip: i64
}
@(Odin_End)


<Orc>
//Orc 'code' goes here
</Orc>