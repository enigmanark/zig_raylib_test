const std = @import("std");
const rl = @cImport({
    @cInclude("raylib.h");
});
const res_art = @import("./art_cache.zig");

pub fn main() !void {
    rl.InitWindow(1366, 768, "Hello!");
    defer rl.CloseWindow();
    var resource_allocator = std.heap.GeneralPurposeAllocator(.{}){};

    const gpa = resource_allocator.allocator();
    defer _ = resource_allocator.deinit();

    var art_cache = try res_art.ArtCache.init_and_load(&gpa);
    defer art_cache.unload();

    const tex = art_cache.get_art(res_art.ArtAsset.Hero);

    while(!rl.WindowShouldClose()) {

        rl.BeginDrawing();

        rl.DrawTexture(tex, 0, 0, rl.WHITE);

        rl.EndDrawing();

    }
}
