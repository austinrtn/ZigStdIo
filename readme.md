# ZigStdIo 
A Zig tool that gives the user simple ways to output to `stdout` and `stderr`, as well as to read from `stdin`.  

## To Install: 
> **Command Line**:  
> ```zig fetch --save ""https://github.com/austinrtn/ZigStdIo/archive/refs/tags/1.1.tar.gz```

> **build.zig**: 
> ```zig
> const stdio_dep = b.dependency("ZigStdIo", .{.targert = target});
> const stdio_mod = b.stdio_dep.module("ZigStdIo");
> exe.root_module.addImport("ZigStdIo", stdio_mod);
>```

# Example: 
```zig
pub fn main(init: std.process.Init) !void {
    var stdio = try Stdio.init(init.gpa, init.io, 1024);
    defer stdio.deinit();
    
    try stdio.cls(); // Clear screen
    try stdio.writeln("Hello world");
    try stdio.print("Today is: {s}\n", .{"Tuesday"});

    const name = try stdio.captureInputAlloc("What is your name: ", .{}, init.gpa);
    defer init.gpa.free(name);
    try stdio.print("That's a nice name {s}\n", .{name});

    const hello_world = try stdio.input("Type in \"Hello World\"\n", .{});

    if(!std.mem.eql(u8, hello_world, "Hello World")) {
        try stdio.errorPrint("Program failed!\n", .{}, 69);
    }
}
```