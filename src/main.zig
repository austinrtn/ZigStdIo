const std = @import("std");
const Stdio = @import("ZigStdIo").StdIo;

pub fn main(init: std.process.Init) !void {
    var stdio = try Stdio.init(init.gpa, init.io, 1024);
    defer stdio.deinit();
    
    try stdio.println("Hello world");
    try stdio.print("Today is: {s}\n", .{"Tuesday"});

    const name = try stdio.captureInputAlloc("What is your name: ", .{}, init.gpa);
    defer init.gpa.free(name);
    try stdio.print("That's a nice name {s}\n", .{name});

    const res2 = try stdio.input("Lets try a second prompt: ", .{});
    try stdio.print("First input: {s}\n", .{name});
    try stdio.print("Second input: {s}\n", .{res2});

    const args = try init.minimal.args.toSlice(init.arena.allocator());
    if(args.len > 1 and std.mem.eql(u8, args[1], "--fail")) {
        try stdio.errorPrint("Program failed", .{}, 69);
    }
}