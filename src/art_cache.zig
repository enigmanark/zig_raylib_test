const std = @import("std");
const rl = @cImport({
    @cInclude("raylib.h");
});

pub const ArtAsset = enum {
    Hero,
};

pub const ArtCache = struct {
    cache : std.AutoHashMap(ArtAsset, rl.Texture2D),

    pub fn get_art(self : *ArtCache, art : ArtAsset) rl.Texture2D {
        return self.cache.get(art).?;
    }

    pub fn init_and_load(allocator : *const std.mem.Allocator) !ArtCache {
        var art_cache = ArtCache {
            .cache = std.AutoHashMap(ArtAsset, rl.Texture2D).init(allocator.*),
        };
        try art_cache.cache.put(ArtAsset.Hero, rl.LoadTexture("res/hero_test.png"));
        return art_cache;
    }

    pub fn unload(self : *ArtCache) void {
        rl.UnloadTexture(self.get_art(ArtAsset.Hero));

        self.cache.deinit();
    }
};
 