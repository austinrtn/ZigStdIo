const std = @import("std");
const Stdio = @import("ZigStdIo").StdIo;

pub fn main(init: std.process.Init) !void {
    var stdio = try Stdio.init(init.gpa, init.io, 1024);
    defer stdio.deinit();
    
    try stdio.cls();
    try stdio.writeln("Hello world");
    try stdio.print("Today is: {s}\n", .{"Tuesday"});

    const name = try stdio.captureInputAlloc("What is your name: ", .{}, init.gpa);
    defer init.gpa.free(name);
    try stdio.print("That's a nice name {s}\n", .{name});

    const hello_world = try stdio.input("Type in \"Hello World\"\n", .{});
    
    if(!std.mem.eql(u8, hello_world, "Hello World")) {
        try stdio.errorPrint("Program failed!\n", .{}, 69);
    }
    
    try stdio.writeln("Press enter 3 times...");
    try stdio.writeAndHold("Holding 1...");
    _ = try stdio.input(null, .{});
    try stdio.writeAndHold("Holding 2...");
    _ = try stdio.input(null, .{});
    try stdio.writeAndHold("Holding 3...");
    _ = try stdio.input(null, .{});

    try stdio.flushStdout();
}