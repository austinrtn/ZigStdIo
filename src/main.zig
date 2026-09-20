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
    
    while(true) {
        const number = try stdio.strictInput("Pick a number 1-3: ", .{}, &.{"1", "2", "3"}, false);
        switch(number) {
            .@"1" => { try stdio.writeln("It was his hat Mr.Krabs, he was number one!"); },
            .@"2" => { try stdio.writeln("Balance is the key to life!"); },
            .@"3" => { try stdio.writeln("Three is the place to be!"); },
            .invalid => {
                try stdio.cls();
                try stdio.writeln("Invalid input - Try again!");
                continue;
            },
        }
        break;
    }
    
    try stdio.writeln("Press enter 3 times...");
    try stdio.writeNoFlush("Holding 1...");
    _ = try stdio.input(null, .{});
    try stdio.writeNoFlush("Holding 2...");
    _ = try stdio.input(null, .{});
    try stdio.writeNoFlush("Holding 3...");
    _ = try stdio.input(null, .{});

    try stdio.flushStdout();
}