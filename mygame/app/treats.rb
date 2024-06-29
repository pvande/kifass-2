x0 = TEXTURE_SIZE * 0
x1 = TEXTURE_SIZE * 1
x2 = TEXTURE_SIZE * 2
x3 = TEXTURE_SIZE * 3
x4 = TEXTURE_SIZE * 4
x5 = TEXTURE_SIZE * 5
x6 = TEXTURE_SIZE * 6
x7 = TEXTURE_SIZE * 7
x8 = TEXTURE_SIZE * 8

TREATS = {
  cookie: {
    found: [:cookie_jar, :default],
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x2, tile_y: x0, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x0, tile_y: x0, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x1, tile_y: x0, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x3, tile_y: x0, tile_w: x1, tile_h: x1 },
  },
  pink_donut: {
    found: [:pantry, :lower],
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x2, tile_y: x1, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x0, tile_y: x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x1, tile_y: x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x3, tile_y: x1, tile_w: x1, tile_h: x1 },
  },
  chocolate_donut: {
    found: [:pantry, :lower],
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x2, tile_y: x2, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x0, tile_y: x2, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x1, tile_y: x2, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x3, tile_y: x2, tile_w: x1, tile_h: x1 },
  },
  candy_bar: {
    found: [:pantry, :upper],
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x2, tile_y: x3, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x0, tile_y: x3, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x1, tile_y: x3, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x3, tile_y: x3, tile_w: x1, tile_h: x1 },
  },
  pudding_cup: {
    found: [:pantry, :upper],
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x2, tile_y: x4, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x0, tile_y: x4, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x1, tile_y: x4, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x3, tile_y: x4, tile_w: x1, tile_h: x1 },
  },
  cone: {
    found: [:fridge, :freezer],
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x2, tile_y: x5, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x0, tile_y: x5, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x1, tile_y: x5, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x3, tile_y: x5, tile_w: x1, tile_h: x1 },
  },
  popscicle: {
    found: [:fridge, :freezer],
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x2, tile_y: x6, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x0, tile_y: x6, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x1, tile_y: x6, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x3, tile_y: x6, tile_w: x1, tile_h: x1 },
  },
  soda: {
    found: [:fridge, :fridge],
    n: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x2, tile_y: x7, tile_w: x1, tile_h: x1 },
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x0, tile_y: x7, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x1, tile_y: x7, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.8, path: "sprites/treats.png", tile_x: x3, tile_y: x7, tile_w: x1, tile_h: x1 },
  },

  pot_of_soup: {
    found: nil,
    n: {},
    s: { w: x2 + 4, h: x2, anchor_x: 0.55, anchor_y: 0.2, path: "sprites/tileset.png", tile_x: x6, tile_y: 17 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: 0.1, path: "sprites/tileset.png", tile_x: x6, tile_y: 17 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: 0.1, path: "sprites/tileset.png", tile_x: x6, tile_y: 17 * x1, tile_w: x1, tile_h: x1 },
  },
  empty_pot: {
    found: nil,
    n: {},
    s: { w: x2 + 4, h: x2, anchor_x: 0.55, anchor_y: 0.2, path: "sprites/tileset.png", tile_x: x7, tile_y: 17 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: 0.2, path: "sprites/tileset.png", tile_x: x7, tile_y: 17 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: 0.2, path: "sprites/tileset.png", tile_x: x7, tile_y: 17 * x1, tile_w: x1, tile_h: x1 },
  },
  garbage: {
    found: nil,
    n: {},
    s: { w: x2 + 4, h: x2, anchor_x: 0.55, anchor_y: 0.2, path: "sprites/tileset.png", tile_x: x8, tile_y: 17 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: 0.2, path: "sprites/tileset.png", tile_x: x8, tile_y: 17 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: 0.2, path: "sprites/tileset.png", tile_x: x8, tile_y: 17 * x1, tile_w: x1, tile_h: x1 },
  },
  water: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/tileset.png", tile_x: x5, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x5, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: 0, path: "sprites/tileset.png", tile_x: x5, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
  },
  flour: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/tileset.png", tile_x: x6, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x6, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: 0, path: "sprites/tileset.png", tile_x: x6, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
  },
  yeast: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/tileset.png", tile_x: x7, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x7, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: 0, path: "sprites/tileset.png", tile_x: x7, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
  },
  dough: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/tileset.png", tile_x: x8, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x8, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: 0, path: "sprites/tileset.png", tile_x: x8, tile_y: 18 * x1, tile_w: x1, tile_h: x1 },
  },
  broth: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/tileset.png", tile_x: x4, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: -0.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x4, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 1.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x4, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
  },
  whole_soft_veg: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/tileset.png", tile_x: x5, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: -0.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x5, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 1.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x5, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
  },
  whole_meat: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/tileset.png", tile_x: x6, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: -0.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x6, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 1.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x6, tile_y: 19 * x1, tile_w: x1, tile_h: x1, flip_horizontally: true },
  },
  whole_hard_veg: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/tileset.png", tile_x: x7, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x7, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: 0, path: "sprites/tileset.png", tile_x: x7, tile_y: 19 * x1, tile_w: x1, tile_h: x1, flip_horizontally: true },
  },
  whole_root_veg: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/tileset.png", tile_x: x8, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x8, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: 0, path: "sprites/tileset.png", tile_x: x8, tile_y: 19 * x1, tile_w: x1, tile_h: x1 },
  },
  cut_soft_veg: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x5, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: -0.1, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x5, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 1.1, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x5, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
  },
  cut_meat: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x6, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: -0.1, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x6, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 1.1, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x6, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
  },
  cut_hard_veg: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x7, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x7, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x7, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
  },
  cut_root_veg: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x8, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x8, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: -0.2, path: "sprites/tileset.png", tile_x: x8, tile_y: 20 * x1, tile_w: x1, tile_h: x1 },
  },
  dish: {
    found: nil,
    n: {},
    s: { w: x2, h: x2, anchor_x: 0.5, anchor_y: 0, path: "sprites/tileset.png", tile_x: x8, tile_y: 21 * x1, tile_w: x1, tile_h: x1 },
    e: { w: x2, h: x2, anchor_x: 0.1, anchor_y: 0, path: "sprites/tileset.png", tile_x: x8, tile_y: 22 * x1, tile_w: x1, tile_h: x1, flip_horizontally: true },
    w: { w: x2, h: x2, anchor_x: 0.9, anchor_y: 0, path: "sprites/tileset.png", tile_x: x8, tile_y: 22 * x1, tile_w: x1, tile_h: x1 },
  },
}
