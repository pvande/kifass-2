x0 = TEXTURE_SIZE * 0
x1 = TEXTURE_SIZE * 1
x2 = TEXTURE_SIZE * 2
x3 = TEXTURE_SIZE * 3
x4 = TEXTURE_SIZE * 4
x5 = TEXTURE_SIZE * 5
x6 = TEXTURE_SIZE * 6

DROPS = {
  single_bed: {
    x: 35,
    y: 19,
    test: proc { true },
  },
  nightstand: {
    x: 36,
    y: 19,
    test: proc { true },
  },
  double_bed: {
    x: 35,
    y: 4,
    test: proc { true },
  },
  couch: {
    x: 24,
    y: 19,
    test: proc { true },
  },
}

$gtk.reset
