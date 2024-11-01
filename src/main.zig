const VERSION = "0.1.0";
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const params = comptime clap.parseParamsComptime(
        \\-h, --help                Display this help and exit.
        \\-v, --version             Output version information and exit.
        \\-i, --install <version>   Install a spesific version
        \\-l, --list                List's avaible versions
        \\-u, --use <vesion>        Use spesific vesion
        \\Example:
        \\3cvm --install master
        \\3cvm --use master
    );

    var res = try clap.parse(clap.Help, &params, clap.parsers.default, .{
        .allocator = gpa.allocator(),
    });
    defer res.deinit();

    if (res.args.help != 0)
        return clap.help(std.io.getStdErr().writer(), clap.Help, &params, .{});
    if (res.args.version != 0) {
        std.debug.print("{s}\n", .{VERSION});
    }
}

const clap = @import("clap");
const std = @import("std");
