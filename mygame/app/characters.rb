x0 = TEXTURE_SIZE * 0
x1 = TEXTURE_SIZE * 1
x2 = TEXTURE_SIZE * 2
x3 = TEXTURE_SIZE * 3
x4 = TEXTURE_SIZE * 4
x5 = TEXTURE_SIZE * 5
x6 = TEXTURE_SIZE * 6
x7 = TEXTURE_SIZE * 7
x8 = TEXTURE_SIZE * 8

HERO = {
  standing: {
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x4, tile_y: x4, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x0, tile_y: x4, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x4, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x4, tile_w: x1, tile_h: x1, flip_horizontally: true },
  },
  walking: {
    n: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x5, tile_y: x4, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x5, tile_y: x4, tile_w: x1, tile_h: x1, flip_horizontally: true },
    ],
    s: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x1, tile_y: x4, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x1, tile_y: x4, tile_w: x1, tile_h: x1, flip_horizontally: true },
    ],
    e: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x4, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x3, tile_y: x4, tile_w: x1, tile_h: x1 },
    ],
    w: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x4, tile_w: x1, tile_h: x1, flip_horizontally: true },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x3, tile_y: x4, tile_w: x1, tile_h: x1, flip_horizontally: true },
    ],
  },
  pushing: {
    n: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x4, tile_y: x5, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x5, tile_y: x5, tile_w: x1, tile_h: x1 },
    ],
    s: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x0, tile_y: x5, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x1, tile_y: x5, tile_w: x1, tile_h: x1 },
    ],
    e: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x5, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x3, tile_y: x5, tile_w: x1, tile_h: x1 },
    ],
    w: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x5, tile_w: x1, tile_h: x1, flip_horizontally: true },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x3, tile_y: x5, tile_w: x1, tile_h: x1, flip_horizontally: true },
    ],
  },
  pulling: {
    n: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x4, tile_y: x6, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x5, tile_y: x6, tile_w: x1, tile_h: x1 },
    ],
    s: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x0, tile_y: x6, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x1, tile_y: x6, tile_w: x1, tile_h: x1 },
    ],
    e: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x6, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x3, tile_y: x6, tile_w: x1, tile_h: x1 },
    ],
    w: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x6, tile_w: x1, tile_h: x1, flip_horizontally: true },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x3, tile_y: x6, tile_w: x1, tile_h: x1, flip_horizontally: true },
    ],
  },
  leaning_in: {
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x5, tile_y: x5, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x1, tile_y: x5, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x5, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x5, tile_w: x1, tile_h: x1, flip_horizontally: true },
  },
  leaning_back: {
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x4, tile_y: x6, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x0, tile_y: x6, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x6, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x6, tile_w: x1, tile_h: x1, flip_horizontally: true },
  },
  coiling: {
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x4, tile_y: x7, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x0, tile_y: x7, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x7, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x7, tile_w: x1, tile_h: x1, flip_horizontally: true },
  },
  jumping: {
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x5, tile_y: x7, tile_w: x1, tile_h: x1, flip_horizontally: true },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x1, tile_y: x7, tile_w: x1, tile_h: x1, flip_horizontally: true },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x3, tile_y: x7, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x3, tile_y: x7, tile_w: x1, tile_h: x1, flip_horizontally: true },
  },
  holding: {
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x4, tile_y: x8, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x0, tile_y: x8, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x8, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x8, tile_w: x1, tile_h: x1, flip_horizontally: true },
  },
  carrying: {
    n: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x5, tile_y: x8, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x5, tile_y: x8, tile_w: x1, tile_h: x1, flip_horizontally: true },
    ],
    s: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x1, tile_y: x8, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x1, tile_y: x8, tile_w: x1, tile_h: x1, flip_horizontally: true },
    ],
    e: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x8, tile_w: x1, tile_h: x1 },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x3, tile_y: x8, tile_w: x1, tile_h: x1 },
    ],
    w: [
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x2, tile_y: x8, tile_w: x1, tile_h: x1, flip_horizontally: true },
      { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/zelda-characters.png", tile_x: x3, tile_y: x8, tile_w: x1, tile_h: x1, flip_horizontally: true },
    ],
  },
}

MOMMY = {
  standing: {
    n: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x4, tile_y: x0, tile_w: x1, tile_h: x2 },
    s: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x0, tile_y: x0, tile_w: x1, tile_h: x2 },
    e: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x2, tile_y: x0, tile_w: x1, tile_h: x2 },
    w: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x2, tile_y: x0, tile_w: x1, tile_h: x2, flip_horizontally: true },
  },
  walking: {
    n: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x4, tile_y: x0, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x5, tile_y: x0, tile_w: x1, tile_h: x2 },
    ],
    s: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x0, tile_y: x0, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x1, tile_y: x0, tile_w: x1, tile_h: x2 },
    ],
    e: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x2, tile_y: x0, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x3, tile_y: x0, tile_w: x1, tile_h: x2 },
    ],
    w: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x2, tile_y: x0, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x3, tile_y: x0, tile_w: x1, tile_h: x2, flip_horizontally: true },
    ],
  },
  holding: {
    n: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x4, tile_y: x2, tile_w: x1, tile_h: x2 },
    s: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x0, tile_y: x2, tile_w: x1, tile_h: x2 },
    e: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x2, tile_y: x2, tile_w: x1, tile_h: x2 },
    w: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x2, tile_y: x2, tile_w: x1, tile_h: x2, flip_horizontally: true },
  },
  carrying: {
    n: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x5, tile_y: x2, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x5, tile_y: x2, tile_w: x1, tile_h: x2, flip_horizontally: true },
    ],
    s: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x1, tile_y: x2, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x1, tile_y: x2, tile_w: x1, tile_h: x2, flip_horizontally: true },
    ],
    e: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x2, tile_y: x2, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x3, tile_y: x2, tile_w: x1, tile_h: x2 },
    ],
    w: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x2, tile_y: x2, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x3, tile_y: x2, tile_w: x1, tile_h: x2, flip_horizontally: true },
    ],
  },
  washing: {
    n: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x4, tile_y: x2, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x5, tile_y: x2, tile_w: x1, tile_h: x2 },
    ],
    e: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x0, tile_y: x4, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x1, tile_y: x4, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x2, tile_y: x4, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x3, tile_y: x4, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x4, tile_y: x4, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x5, tile_y: x4, tile_w: x1, tile_h: x2 },
    ],
    w: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x0, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x1, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x2, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x3, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x4, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/moeder.png", tile_x: x5, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
    ],
  },
}

DADDY = {
  standing: {
    n: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x4, tile_y: x0, tile_w: x1, tile_h: x2 },
    s: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x0, tile_y: x0, tile_w: x1, tile_h: x2 },
    e: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x2, tile_y: x0, tile_w: x1, tile_h: x2 },
    w: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x2, tile_y: x0, tile_w: x1, tile_h: x2, flip_horizontally: true },
  },
  walking: {
    n: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x4, tile_y: x0, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x5, tile_y: x0, tile_w: x1, tile_h: x2 },
    ],
    s: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x0, tile_y: x0, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x1, tile_y: x0, tile_w: x1, tile_h: x2 },
    ],
    e: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x2, tile_y: x0, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x3, tile_y: x0, tile_w: x1, tile_h: x2 },
    ],
    w: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x2, tile_y: x0, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x3, tile_y: x0, tile_w: x1, tile_h: x2, flip_horizontally: true },
    ],
  },
  holding: {
    n: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x4, tile_y: x2, tile_w: x1, tile_h: x2 },
    s: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x0, tile_y: x2, tile_w: x1, tile_h: x2 },
    e: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x2, tile_y: x2, tile_w: x1, tile_h: x2 },
    w: { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x2, tile_y: x2, tile_w: x1, tile_h: x2, flip_horizontally: true },
  },
  carrying: {
    n: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x5, tile_y: x2, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x5, tile_y: x2, tile_w: x1, tile_h: x2, flip_horizontally: true },
    ],
    s: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x1, tile_y: x2, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x1, tile_y: x2, tile_w: x1, tile_h: x2, flip_horizontally: true },
    ],
    e: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x2, tile_y: x2, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x3, tile_y: x2, tile_w: x1, tile_h: x2 },
    ],
    w: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x2, tile_y: x2, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x3, tile_y: x2, tile_w: x1, tile_h: x2, flip_horizontally: true },
    ],
  },
  washing: {
    n: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x4, tile_y: x2, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x5, tile_y: x2, tile_w: x1, tile_h: x2 },
    ],
    e: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x0, tile_y: x4, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x1, tile_y: x4, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x2, tile_y: x4, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x3, tile_y: x4, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x4, tile_y: x4, tile_w: x1, tile_h: x2 },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x5, tile_y: x4, tile_w: x1, tile_h: x2 },
    ],
    w: [
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x0, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x1, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x2, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x3, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x4, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
      { w: x2, h: x4, anchor_x: 0.5, anchor_y: 0, path: "sprites/vader.png", tile_x: x5, tile_y: x4, tile_w: x1, tile_h: x2, flip_horizontally: true },
    ],
  },
}
