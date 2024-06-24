$gtk.disable_nil_punning!
# $gtk.disable_aggressive_gc!
# GC.generational_mode = false

TEXTURE_SIZE = 16
GRID_SIZE = 32

class GTK::Inputs
  def left_right_perc
    if @holding_finger_left
      @holding_finger_left &&= $inputs.finger_left
    else
      @holding_finger_left = $inputs.finger_left.intersect_rect?(virtual_direction_controls) if $inputs.finger_left
    end

    @virtual_direction_angle = if @holding_finger_left
      $outputs.debug << virtual_direction_controls.center.to_solid(w: 20, h: 20, align_x: 0.5, align_y: 0.5)
      $geometry.angle_to(virtual_direction_controls.center, $inputs.finger_left)
    end

    if @virtual_direction_angle
      @virtual_direction_angle.vector_x
    elsif controller_one && controller_one.left_analog_x_perc != 0
      controller_one.left_analog_x_perc
    else
      left_right
    end
  end

  def up_down_perc
    if @virtual_direction_angle
      @virtual_direction_angle.vector_y
    elsif controller_one && controller_one.left_analog_y_perc != 0
      controller_one.left_analog_y_perc
    else
      up_down
    end
  end

  def virtual_direction_input
    [
      $layout.rect(row: 10, col: 0, w: 3, h: 1).solid!(r: 255, g: 255, b: 255, a: 100),
      $layout.rect(row: 9, col: 1, w: 1, h: 3).solid!(r: 255, g: 255, b: 255, a: 100),
      (line_from(virtual_direction_controls.center, $inputs.finger_left).line!(g: 100, a: 100) if @holding_finger_left),
    ]
  end

  def virtual_direction_controls
    $layout.rect(row: 9, col: 0, w: 3, h: 3)
  end

  def virtual_button_input
    $layout.rect(row: 9, col: 21, w: 3, h: 3).solid!(r: 255, g: 255, b: 255, a: 100)
  end
end

class Integer
  def prev
    self - 1
  end
end

require_relative "interactives"
require_relative "objectives"
require_relative "characters"
require_relative "treats"
require_relative "drops"

TILES = 333.times.map do |i|
  { w: GRID_SIZE, h: GRID_SIZE, path: "sprites/tileset.png", tile_x: 16 * (i % 9), tile_y: 16 * i.idiv(9), tile_w: 16, tile_h: 16 }
end

def recompute_grid!
  $base = BASE_LAYER.each.to_h do |key, (tile, rot, flip)|
    xpos, ypos = key
    [key, TILES[tile].merge(x: GRID_SIZE * xpos, y: GRID_SIZE * ypos, angle: rot * 90, flip_horizontally: flip)]
  end

  $mid = MID_LAYER.each.to_h do |key, (tile, rot, flip)|
    xpos, ypos = key
    [key, TILES[tile].merge(x: GRID_SIZE * xpos, y: GRID_SIZE * ypos, angle: rot * 90, flip_horizontally: flip)]
  end

  $stools = MOVE_LAYER.each.to_h do |key, (tile, rot, flip)|
    xpos, ypos = key
    [key, TILES[tile].merge(x: GRID_SIZE * xpos, y: GRID_SIZE * ypos, ox: GRID_SIZE * xpos, oy: GRID_SIZE * ypos, w: GRID_SIZE.mult(0.8), h: GRID_SIZE.half, angle: rot * 90, flip_horizontally: flip).tap { |x| x.merge!(id: x.object_id) }]
  end

  $opportunities = []
  $interactives = {}
  $interactives_by_name = {}
  INTERACTIVES.each do |name, interactive|
    xpos, ypos = interactive.values_at(:x, :y)
    obj = interactive.merge(x: GRID_SIZE * xpos, y: GRID_SIZE * ypos, current_state: :default, **interactive.states[:default])

    $opportunities += Array(interactive.opportunities).map do |opportunity|
      opportunity.merge(location: [name, opportunity[:test]], test: interactive.states[:default].transitions[opportunity[:test]])
    end

    $interactives[[xpos, ypos]] = obj
    $interactives_by_name[name] = obj
  end

  $low_deco = LOW_DECO_LAYER.each.to_h do |key, (tile, rot, flip)|
    xpos, ypos = key
    [key, TILES[tile].merge(x: GRID_SIZE * xpos, y: GRID_SIZE * ypos, angle: rot * 90, flip_horizontally: flip)]
  end.compact

  $hi_deco = HI_DECO_LAYER.each.to_h do |key, (tile, rot, flip)|
    xpos, ypos = key
    [key, TILES[tile].merge(x: GRID_SIZE * xpos, y: GRID_SIZE * ypos, angle: rot * 90, flip_horizontally: flip)]
  end.compact

  $outputs[:map].w = $grid.rect.w
  $outputs[:map].h = $grid.rect.h
  $outputs[:map].sprites << $base.values
  $outputs[:map].sprites << $low_deco.values
  $outputs[:map].sprites << $mid.values
end

def boot(...)
  eval $gtk.read_file("app/layers.rb")
  eval $gtk.read_file("app/los.rb")
  recompute_grid!
end

$scratch = $args.temp_state

def init
  $state.mode = :title
  # $state.mode = :game
  # $state.mode = :game_over
  # $state.failed = 1
  # $state.score = [:cookie, :candy_bar, :pudding_cup, :soda, :cone, :popscicle, :pink_donut, :chocolate_donut]

  $state.scene = { alpha: 255, advancing_to: nil }
  $state.debug = {
    show_pathfinding: false,
    show_visual_cones: false,
  }

  $state.editor = {
    layer: 0,
    selected: 0,
    rotation: 0,
    flip: false,
    palette: {
      dragging: false,
      bounds: { x: 1006, y: 50, w: 164, h: 620 },
      handle: { x: 1006, y: 660, w: 164, h: 10 },
      sprite: { x: 1016, y: 60, w: 144, h: 592, path: "sprites/tileset.png" },
    },
  }
end

def init_game
  $state.failed = nil
  $state.score = []

  $state.hero = {
    name: "lucy",
    x: 1154,
    y: 560,
    w: 20,
    h: 8,
    anchor_x: 0.5,
    anchor_y: 0,
    last_moved: 0,
    facing: :s,
    action: :standing,
    level: nil,
    time_without_contraband: 0,
    carrying: nil,
  }

  $state.opportunity = nil
  $state.couch = []
  $state.stove = { carrying: nil }
  $state.in_progress = {}
  $state.in_use = { oven: false }
  $state.timers = {
    dishes: 0,
    laundry: 0,
    trash: 0,
    soup: 0,
    oven: 0,
    # dough: nil,
  }

  $state.daddy = {
    name: "daddy",
    x: 1138,
    y: 104,
    w: 20,
    h: 8,
    anchor_x: 0.5,
    anchor_y: 0,
    path: [],
    last_moved: 0,
    action: :standing,
    facing: :s,
    facing_changed: 0,
    duration: 0,
    agenda: [],
    bathroom_timer: 0,
    carrying: nil,
 }

  $state.mommy = {
    name: "mommy",
    x: 994,
    y: 96,
    w: 20,
    h: 8,
    anchor_x: 0.5,
    anchor_y: 0,
    path: [],
    last_moved: 0,
    action: :standing,
    facing: :s,
    facing_changed: 0,
    duration: 0,
    agenda: [],
    bathroom_timer: 0,
    carrying: nil,
  }

  $actors = [
    $state.hero.tap { |x| x.merge!(id: x.object_id) },
    $state.mommy.tap { |x| x.merge!(id: x.object_id) },
    $state.daddy.tap { |x| x.merge!(id: x.object_id) },
  ]

  $state.music = {
    playbacks: [:one, :two],
    failed: { input: "sounds/failed.mp3", gain: 0.2, maximum: 0.2 },
    bass: { input: "sounds/bass.mp3", gain: 1.0, maximum: 1.0 },
    drums: { input: "sounds/drums.mp3", gain: 0.01, maximum: 0.5 },
    bells: { input: "sounds/bells.mp3", gain: 0.01, maximum: 0.4 },
    danger: { input: "sounds/danger.mp3", gain: 0.0, maximum: 0.2 },
  }

  $audio[:bass_one] = $state.music.bass.dup
  $audio[:drums_one] = $state.music.drums.dup
  $audio[:bells_one] = $state.music.bells.dup
  $audio[:danger_one] = $state.music.danger.dup
  $audio[:bass_two] = nil
  $audio[:drums_two] = nil
  $audio[:bells_two] = nil
  $audio[:danger_two] = nil

  $interactives.each_value { _1.merge!(current_state: :default, **_1.states[:default]) }
  $stools.each_value { _1.merge!(x: _1.ox, y: _1.oy) }
end

def loop_bg_music
  $state.music.playbacks.rotate!
  playback = $state.music.playbacks.first
  $audio[:"bass_#{playback}"] = $state.music.bass.dup
  $audio[:"drums_#{playback}"] = $state.music.drums.dup
  $audio[:"bells_#{playback}"] = $state.music.bells.dup
  $audio[:"danger_#{playback}"] = $state.music.danger.dup unless $state.failed
end

def set_track_gain(track, gain)
  $state.music[track].gain = $state.music[track].maximum * gain.clamp(0.0, 1.0)
end

def reset(...)
  recompute_grid!
end

$max_time = 0
$avg_time = 0
def tick(...)
  init if Kernel.tick_count.zero?

  # $inputs.http_requests.each do |req|
  #   if req.uri.start_with?("/game/")
  #     file = "web" + req.uri.delete_prefix("/game")
  #     type = case req.uri.split(".").last
  #     when "html" then "text/html"
  #     when "wasm" then "application/wasm"
  #     when "js" then "application/javascript"
  #     else "text/plain"
  #     end

  #     contents = $gtk.read_file(file)
  #     if contents
  #       req.respond 200, contents, { "Content-Type": type }
  #     else
  #       req.reject
  #     end
  #   end
  # end

  $outputs = $args.outputs[:backbuffer]
  $outputs.h = 22 * GRID_SIZE
  $outputs.background_color = [0, 0, 0]
  $outputs.transient!

  $state.mode = ($state.mode == :editor ? :game : :editor) if $inputs.keyboard.ctrl_e
  $state.debug.show_pathfinding ^= true if $inputs.keyboard.key_down.p

  # time = Time.now

  if $state.scene.advancing_to
    $state.scene.alpha -= 2
    unless $state.scene.alpha.positive?
      $state.mode = $state.scene.advancing_to
      $state.scene.advancing_to = nil
      Kernel.tick_count = 0
    end
  elsif $state.scene.alpha < 255
    $state.scene.alpha += 2
  end

  case $state.mode
  when :editor then tick_editor
  when :title then tick_title
  when :game then tick_game
  when :game_over then tick_game_over
  end

  $args.outputs.background_color = [0, 0, 0]
  $args.outputs.sprites << { **$grid.rect, y: 8, h: $outputs.h, path: :backbuffer, a: $state.scene.alpha }

  $bg_fiber.resume if $bg_fiber

  # time = (Time.now - time).mult(1000)
  # $max_time = time if time > $max_time
  # $avg_time *= Kernel.tick_count
  # $avg_time /= Kernel.tick_count.add(1) unless $avg_time.zero?
  # $avg_time += time / Kernel.tick_count.add(1)
  # $args.outputs.debug << "NOW: #{time.to_sf}ms"
  # $args.outputs.debug << "MAX: #{$max_time.to_sf}ms"
  # $args.outputs.debug << "AVG: #{$avg_time.to_sf}ms"
  # $args.outputs.debug << "FPS: #{$gtk.current_framerate.to_sf}fps"
  # $args.outputs.debug << $state.hero.values_at(:x, :y).inspect
end

def tick_editor
  editor_mode
  $outputs.sprites << $base.values.map { |x| x.merge(a: $state.editor.layer == 0 ? 255 : 50) }
  $outputs.sprites << $low_deco.values.map { |x| x.merge(a: $state.editor.layer == 1 ? 255 : 50) }
  $outputs.sprites << $mid.values.map { |x| x.merge(a: $state.editor.layer == 2 ? 255 : 50) }
  $outputs.sprites << $stools.values.map { |x| x.merge(a: $state.editor.layer == 3 ? 255 : 50) }
  $outputs.sprites << $hi_deco.values.map { |x| x.merge(a: $state.editor.layer == 4 ? 255 : 50) }
end

def tick_title
  color = { r: 164 }
  if $inputs.mouse.intersect_rect?({ x: 360.from_right, y: (32 + 128).from_top - 5, w: 256, h: 59 })
    color = { r: 221 }
    $state.scene.advancing_to = :game if $inputs.mouse.down
  end

  $state.scene.advancing_to = :game if $inputs.keyboard.key_down.enter || $inputs.controller_one.key_down.a

  $args.outputs[:menu_arrow].w = 64
  $args.outputs[:menu_arrow].h = 64
  $args.outputs[:menu_arrow].background_color = [158, 188, 221]
  $args.outputs[:menu_arrow].transient!
  $args.outputs[:menu_arrow].labels << { x: 0, y: -20, w: 256, h: 64, text: "7", size_enum: 24, font: "fonts/handwriting.otf", alignment_enum: 0, vertical_alignment_enum: 0, **color }

  $args.outputs[:menu_prerender].w = 256
  $args.outputs[:menu_prerender].h = 64
  $args.outputs[:menu_prerender].background_color = [158, 188, 221]
  $args.outputs[:menu_prerender].transient!
  $args.outputs[:menu_prerender].labels << { x: 0, y: -10, text: "Start!", size_enum: 20, font: "fonts/handwriting.otf", alignment_enum: 0, vertical_alignment_enum: 0, **color }
  $args.outputs[:menu_prerender].sprites << { x: 206, y: -4, w: 64, h: 64, angle: -20, path: :menu_arrow }

  $args.outputs[:menu].w = 128
  $args.outputs[:menu].h = 32
  $args.outputs[:menu].transient!
  $args.outputs[:menu].sprites << { x: 0, y: 0, w: 128, h: 32, path: :menu_prerender }

  $outputs.primitives << $grid.rect.merge(path: "sprites/titlescreen.png").sprite!
  $outputs.primitives << { x: 32, y: (32 + 128).from_top, w: 256, h: 128, path: "sprites/logo.png" }.sprite!
  $outputs.primitives << { x: 360.from_right, y: (32 + 128).from_top - (Math.sin(Kernel.tick_count / 20) * 5).idiv(2).mult(2), w: 256, h: 64, path: "menu" }.sprite!
end

def tick_game
  init_game if Kernel.tick_count.zero?
  loop_bg_music if Kernel.tick_count > 0 && Kernel.tick_count.zmod?(655)

  $state.music.each do |name, track|
    next if name == :playbacks
    if name == :failed && $audio.failed
      $audio.failed.gain += ($state.music.failed.gain - $audio.failed.gain) / 4.0
    else
      $audio[:"#{name}_one"].gain += ($state.music[name].gain - $audio[:"#{name}_one"].gain) / 4.0 if $audio[:"#{name}_one"]
      $audio[:"#{name}_two"].gain += ($state.music[name].gain - $audio[:"#{name}_two"].gain) / 4.0 if $audio[:"#{name}_two"]
    end
  end

  hero = update_hero
  mommy = update_mommy
  daddy = update_daddy

  $state.timers.transform_values!(&:prev)

  unless $state.opportunity
    $state.opportunity = $state.hero.carrying ? DROPS.values.sample : $opportunities.sample
  end

  $outputs.sprites << $grid.rect.merge(x: 0, y: 0, path: :map)
  $outputs.sprites << $interactives.values
  $outputs.sprites << TREATS[$state.stove.carrying][:w].merge(x: 246, y: 650, anchor_x: 0.5, anchor_y: 0.2) if $state.stove.carrying

  debug_pathfinding if $state.debug.show_pathfinding
  $outputs.sprites << {
    x: $state.opportunity.x * GRID_SIZE,
    y: $state.opportunity.y * GRID_SIZE,
    w: GRID_SIZE,
    h: GRID_SIZE,
    anchor_y: $state.opportunity.anchor_y,
    path: "sprites/sparkle.png",
    tile_x: Kernel.tick_count.idiv(10).mod(12) * TEXTURE_SIZE,
    tile_y: 0,
    tile_w: TEXTURE_SIZE,
    tile_h: TEXTURE_SIZE,
  }

  stools = $stools.values.map { |x| x.merge(w: GRID_SIZE, h: GRID_SIZE) }
  $outputs.sprites << [hero, mommy, daddy, *stools]
    .sort_by { |obj| (obj.level.nil? ? 0 : 32) - obj.y }
    .flat_map do |obj|
      sprite = [obj.merge(x: obj.x.floor, y: obj.y.floor)]
      sprite << TREATS[obj.carrying][obj.facing].merge(x: obj.x, y: obj.y) if obj.carrying
      sprite
    end

  $outputs.sprites << $hi_deco.values

  hx, hy = $state.hero.values_at(:x, :y).map { |x| x.idiv(GRID_SIZE) }
  mx, my = $state.mommy.values_at(:x, :y).map { |x| x.idiv(GRID_SIZE) }
  dx, dy = $state.daddy.values_at(:x, :y).map { |x| x.idiv(GRID_SIZE) }

  mommy_los = ($line_of_sight[[mx, my]] || {}).each_key.select do |key|
    case $state.mommy.facing
    when :n
      (key[1] > my && key[0].subtract(mx).abs <= 2) || (key[1] - 1 > my && key[0].add(-1).subtract(mx).abs <= 4) || key[1] - 2 > my
    when :s
      (key[1] < my && key[0].subtract(mx).abs <= 2) || (key[1] + 1 < my && key[0].add(+1).subtract(mx).abs <= 4) || key[1] + 2 < my
    when :e
      (key[0] > mx && key[1].subtract(my).abs <= 2) || (key[0] - 1 > mx && key[1].add(-1).subtract(my).abs <= 4) || key[0] - 2 > mx
    when :w
      (key[0] < mx && key[1].subtract(my).abs <= 2) || (key[0] + 1 < mx && key[1].add(+1).subtract(my).abs <= 4) || key[0] + 2 < mx
    end
  end

  daddy_los = ($line_of_sight[[dx, dy]] || {}).each_key.select do |key|
    case $state.daddy.facing
    when :n
      (key[1] > dy && key[0].subtract(dx).abs <= 2) || (key[1] - 1 > dy && key[0].add(-1).subtract(dx).abs <= 4) || key[1] - 2 > dy
    when :s
      (key[1] < dy && key[0].subtract(dx).abs <= 2) || (key[1] + 1 < dy && key[0].add(+1).subtract(dx).abs <= 4) || key[1] + 2 < dy
    when :e
      (key[0] > dx && key[1].subtract(dy).abs <= 2) || (key[0] - 1 > dx && key[1].add(-1).subtract(dy).abs <= 4) || key[0] - 2 > dx
    when :w
      (key[0] < dx && key[1].subtract(dy).abs <= 2) || (key[0] + 1 < dx && key[1].add(+1).subtract(dy).abs <= 4) || key[0] + 2 < dx
    end
  end

  if $state.debug.show_visual_cones
    $outputs.primitives << mommy_los.map { |x, y| { x: x * GRID_SIZE, y: y * GRID_SIZE, w: GRID_SIZE, h: GRID_SIZE, r: 255, g: 128, b: 128, a: 128 }.solid! }
    $outputs.primitives << daddy_los.map { |x, y| { x: x * GRID_SIZE, y: y * GRID_SIZE, w: GRID_SIZE, h: GRID_SIZE, r: 128, g: 128, b: 255, a: 128 }.solid! }
  end

  if $state.hero.carrying
    caught = $state.mommy.facing_changed.elapsed?(10) && mommy_los.include?([hx, hy])
    $outputs.lines << { x: $state.hero.x, y: $state.hero.y, x2: $state.mommy.x, y2: $state.mommy.y, r: 255 } if caught

    unless caught
      caught = $state.daddy.facing_changed.elapsed?(10) && daddy_los.include?([hx, hy])
      $outputs.lines << { x: $state.hero.x, y: $state.hero.y, x2: $state.daddy.x, y2: $state.daddy.y, r: 255 } if caught
    end

    danger = 127 + Math.sin(Kernel.tick_count.div(5)).mult(64)
    set_track_gain(:danger, 1.0)
    fail! if caught
    $outputs.sprites << { **$grid.rect, h: $grid.rect.h - 16, path: "sprites/danger.png", a: caught ? 255 : danger }
  else
    danger_level = 255
    timer = $state.hero.time_without_contraband
    offset = timer - 20.seconds
    unless $state.failed
      overtime = offset.fdiv(25.seconds).mult(255)
      pulse = Math.sin(timer.fdiv(35 - offset.fdiv(60))).add(1).mult(10)
      danger_level = overtime.add(pulse).clamp(0, 255)
      fail! if timer >= 45.seconds
    end

    set_track_gain(:danger, offset.fdiv(10.seconds).clamp(0, 1))
    $outputs.sprites << { **$grid.rect, h: $grid.rect.h - 16, path: "sprites/danger.png", r: 0, a: danger_level }
    $outputs.primitives << { **$grid.rect, h: 16, w: $grid.rect.w * (1 - offset.fdiv(25.seconds)) }.solid! if offset.positive?
  end

  if $state.failed&.elapsed?(2.seconds)
    set_track_gain(:bass, 0)
    set_track_gain(:bells, 0)
    set_track_gain(:drums, 0)
    set_track_gain(:failed, 0) if $state.failed.elapsed?(2.2.seconds)
  elsif $state.failed
    set_track_gain(:bass, $state.music.bass.gain * 0.95)
    set_track_gain(:bells, $state.music.bells.gain * 0.95)
    set_track_gain(:drums, $state.music.drums.gain * 0.95)
  else
    set_track_gain(:bells, $state.music.bells.gain / $state.music.bells.maximum * 1.004) if $state.music.bells.gain < $state.music.bells.maximum

    distances = [$state.mommy, $state.daddy].map { $geometry.distance(_1, $state.hero) }
    set_track_gain(:drums, 50 / distances.min)

    if $gtk.platform?(:touch) && !$inputs.controller_one.connected
      $args.outputs.primitives << $inputs.virtual_direction_input
      $args.outputs.primitives << $inputs.virtual_button_input
    end
  end
end

def tick_game_over
  color = { r: 164 }
  if $inputs.mouse.intersect_rect?($layout.rect(row: 10, col: 8.75, w: 6, h: 1.5))
    color = { r: 221 }
    $state.scene.advancing_to = :game if $inputs.mouse.down
  end
  $state.scene.advancing_to = :game if $inputs.keyboard.key_down.enter || $inputs.controller_one.key_down.a

  $outputs.primitives << $grid.rect.to_sprite(path: "sprites/titlescreen.png", a: 40)
  $outputs.primitives << $layout.rect(row: 1, col: 6, w: 12, h: 11).solid!(r: 255, g: 255, b: 255, a: 200)
  $outputs.labels << $layout.rect(row: 1.5, col: 11.75, w: 0, h: 1).label!(text: "Game Over", size_enum: 20, font: "fonts/handwriting.otf", alignment_enum: 1, vertical_alignment_enum: 1)
  $outputs.labels << $layout.rect(row: 3.25, col: 11.75, w: 0, h: 1).label!(text: "Time: %d:%0#{2}d" % $state.failed.idiv(60).divmod(60), size_enum: 10, font: "fonts/handwriting.otf", alignment_enum: 1, vertical_alignment_enum: 1)
  $outputs.labels << $layout.rect(row: 4.5, col: 11.75, w: 0, h: 1).label!(text: "Score: %d" % $state.score.size, size_enum: 10, font: "fonts/handwriting.otf", alignment_enum: 1, vertical_alignment_enum: 1)
    if $state.score.empty?
      $outputs.labels << $layout.rect(row: 5.5, col: 11.75, w: 0, h: 1).label!(text: "Sadly, you failed to", size_enum: 4, font: "fonts/handwriting.otf", alignment_enum: 1, vertical_alignment_enum: 1)
      $outputs.labels << $layout.rect(row: 6.25, col: 11.75, w: 0, h: 1).label!(text: "collect a single treat", size_enum: 4, font: "fonts/handwriting.otf", alignment_enum: 1, vertical_alignment_enum: 1)
      $outputs.labels << $layout.rect(row: 7, col: 11.75, w: 0, h: 1).label!(text: "without being caught...", size_enum: 4, font: "fonts/handwriting.otf", alignment_enum: 1, vertical_alignment_enum: 1)
    elsif $state.score.size == 1
      $state.score.tally.each.with_index do |(treat, count), idx|
        $outputs.primitives << $layout.rect(row: 5.75 + idx.idiv(2), col: 11, w: 1, h: 1).merge(TREATS[treat][:s].slice(:path, :tile_x, :tile_y, :tile_w, :tile_h))
        $outputs.labels << $layout.rect(row: 6 + idx.idiv(2), col: 12, w: 1, h: 1).label!(text: "x#{count}", size_enum: 10, font: "fonts/handwriting.otf", alignment_enum: 0, vertical_alignment_enum: 0)
      end
      $outputs.labels << $layout.rect(row: 7, col: 11.75, w: 0, h: 1).label!(text: "That's it?!", size_enum: 4, font: "fonts/handwriting.otf", alignment_enum: 1, vertical_alignment_enum: 1)
    elsif $state.score.size == 1
      $state.score.tally.each.with_index do |(treat, count), idx|
        $outputs.primitives << $layout.rect(row: 5.75 + idx.idiv(2), col: 11, w: 1, h: 1).merge(TREATS[treat][:s].slice(:path, :tile_x, :tile_y, :tile_w, :tile_h))
        $outputs.labels << $layout.rect(row: 6 + idx.idiv(2), col: 12, w: 1, h: 1).label!(text: "x#{count}", size_enum: 10, font: "fonts/handwriting.otf", alignment_enum: 0, vertical_alignment_enum: 0)
      end
      $outputs.labels << $layout.rect(row: 7, col: 11.75, w: 0, h: 1).label!(text: "That's it?!", size_enum: 4, font: "fonts/handwriting.otf", alignment_enum: 1, vertical_alignment_enum: 1)
    else
      $state.score.tally.each.with_index do |(treat, count), idx|
        $outputs.primitives << $layout.rect(row: 5.75 + idx.idiv(2), col: 9 + 3 * idx.mod(2), w: 1, h: 1).merge(TREATS[treat][:s].slice(:path, :tile_x, :tile_y, :tile_w, :tile_h))
        $outputs.labels << $layout.rect(row: 6 + idx.idiv(2), col: 10 + 3 * idx.mod(2), w: 1, h: 1).label!(text: "x#{count}", size_enum: 10, font: "fonts/handwriting.otf", alignment_enum: 0, vertical_alignment_enum: 0)
      end
    end

  $outputs.labels << $layout.rect(row: 10, col: 11.75, w: 0, h: 1).label!(text: "Try again?", size_enum: 20, font: "fonts/handwriting.otf", alignment_enum: 1, vertical_alignment_enum: 1, **color)
end

def fail!
  return if $state.failed
  $state.failed = Kernel.tick_count
  $state.scene.advancing_to = :game_over
  $audio[:failed] = $state.music.failed.dup
  $audio.delete(:danger_one)
  $audio.delete(:danger_two)
end

def tile_at(x, y, facing = nil)
  xoff, yoff = case facing
  when :n then [0, +1]
  when :s then [0, -1]
  when :e then [+1, 0]
  when :w then [-1, 0]
  else [0, 0]
  end

  [x.idiv(GRID_SIZE).add(xoff), y.idiv(GRID_SIZE).add(yoff)]
end

def editor_mode
  return if $gtk.console.visible?

  if $state.editor.palette.dragging
    $state.editor.palette.bounds = $state.editor.palette.bounds.shift_rect($inputs.mouse.relative_x, $inputs.mouse.relative_y)
    $state.editor.palette.handle = $state.editor.palette.handle.shift_rect($inputs.mouse.relative_x, $inputs.mouse.relative_y)
    $state.editor.palette.sprite = $state.editor.palette.sprite.shift_rect($inputs.mouse.relative_x, $inputs.mouse.relative_y)
  end

  $state.editor.palette.selection = {
    x: $state.editor.palette.sprite.x + $state.editor.selected.mod(9).mult(16),
    y: $state.editor.palette.sprite.y + $state.editor.palette.sprite.h - $state.editor.selected.idiv(9).mult(16) - 16,
    w: 16,
    h: 16,
  }

  $outputs.debug << $state.editor.palette.bounds.dup.solid!(r: 255, g: 128, b: 255)
  $outputs.debug << $state.editor.palette.bounds.dup.border!(r: 0, g: 0, b: 0)
  $outputs.debug << $state.editor.palette.handle.dup.solid!(r: 0, g: 0, b: 0)
  $outputs.debug << $state.editor.palette.selection.dup.solid!(r: 255)
  $outputs.debug << $state.editor.palette.sprite
  $outputs.debug << $state.editor.palette.selection.scale_rect(1.0725, 0.5, 0.5).border!(b: 255)

  key = tile_at($inputs.mouse.x, $inputs.mouse.y)
  xpos, ypos = key

  $args.outputs.debug << "Editing layer: #{%w[BASE LOW_DECO MID MOVE HI_DECO][$state.editor.layer]}"
  $outputs.debug << {
    x: xpos * GRID_SIZE,
    y: ypos * GRID_SIZE,
    w: GRID_SIZE,
    h: GRID_SIZE,
    g: 255,
    a: 20,
  }.border!

  layers = [BASE_LAYER, LOW_DECO_LAYER, MID_LAYER, MOVE_LAYER, HI_DECO_LAYER]
  edit_layer = layers[$state.editor.layer]

  if $inputs.keyboard.key_down.open_square_brace || $inputs.mouse.click && $inputs.mouse.button_x1
    return $state.editor.layer = (layers.size + $state.editor.layer - 1).mod(layers.size)
  elsif $inputs.keyboard.key_down.close_square_brace || $inputs.mouse.click && $inputs.mouse.button_x2
    return $state.editor.layer = (layers.size + $state.editor.layer + 1).mod(layers.size)
  end

  tile, rot, flip = *(edit_layer[key] || [0, 0, false])

  $state.editor.palette.dragging &&= $inputs.mouse.button_left
  if $inputs.mouse.inside_rect?($state.editor.palette.bounds)
    if $inputs.mouse.inside_rect?($state.editor.palette.handle)
      $state.editor.palette.dragging = $inputs.mouse.button_left
    elsif $inputs.mouse.inside_rect?($state.editor.palette.sprite)
      if $inputs.mouse.click && $inputs.mouse.button_left
        xpos = $inputs.mouse.x.subtract($state.editor.palette.sprite.x).idiv(16)
        ypos = ($state.editor.palette.sprite.h + $state.editor.palette.sprite.y - $inputs.mouse.y).idiv(16)
        $state.editor.selected = xpos + ypos * 9
      end
    end

    return
  end

  if $inputs.mouse.click
    $state.editor.mode = $inputs.mouse.button_left ? :painting : :erasing
  elsif $inputs.mouse.up
    $state.editor.mode = nil
  end

  if $state.editor.mode == :painting
    edit_layer[key] = [$state.editor.selected, $state.editor.rotation, $state.editor.flip]
  elsif $state.editor.mode == :erasing
    edit_layer.delete(key)
  elsif $inputs.keyboard.key_down.c
    $state.editor.selected = tile || 0
    $state.editor.rotation = rot || 0
    $state.editor.flip = flip || false
    return
  elsif $inputs.keyboard.key_down.left
    $state.editor.selected = $state.editor.selected.add(-1).mod(edit_layer.size)
    return
  elsif $inputs.keyboard.key_down.right
    $state.editor.selected = $state.editor.selected.add(+1).mod(edit_layer.size)
    return
  elsif $inputs.keyboard.key_down.r
    edit_layer[key] = [tile, (rot - 1).mod(4), flip]
  elsif $inputs.keyboard.key_down.f
    edit_layer[key] = [tile, rot, !flip]
  else
    return
  end

  recompute_grid!

  special_tiles = [
    [18, -1], [18, -2], [18, -3], [19, -1], [19, -2], [19, -3],
    [12, 22], [13, 22],
    [19, 19], [20, 19], [21, 19], [22, 19], [23, 19], [24, 19],
    [35, 4], [36, 4],
  ]

  $line_of_sight = ($base.keys - $mid.keys + special_tiles).to_h { |key| [key, {}] }
  lines_of_sight = []
  combinations = $line_of_sight.keys.combination(2)
  combinations.each do |from, to|
    points = points_between(from, to) & points_between(to, from)
    next unless points
    lines_of_sight << "$line_of_sight[#{from.inspect}][#{to.inspect}] = $line_of_sight[#{to.inspect}][#{from.inspect}] = #{points.inspect}"
    $line_of_sight[from][to] = $line_of_sight[to][from] = points
  end

  $gtk.write_file("app/los.rb", <<~RUBY)
    $line_of_sight = {}
    #{ $line_of_sight.keys.map { |key| "$line_of_sight[#{key}] = {}\n" }.join }
    #{ lines_of_sight.join("\n") }
  RUBY

  $gtk.write_file("app/layers.rb", <<~RUBY)
    BASE_LAYER = {}
    #{BASE_LAYER.each.map { |key, tile| "BASE_LAYER[#{key}] = #{tile.inspect}\n" }.join}
    MID_LAYER = {}
    #{MID_LAYER.each.map { |key, tile| "MID_LAYER[#{key}] = #{tile.inspect}\n" }.join}
    MOVE_LAYER = {}
    #{MOVE_LAYER.each.map { |key, tile| "MOVE_LAYER[#{key}] = #{tile.inspect}\n" }.join}
    LOW_DECO_LAYER = {}
    #{LOW_DECO_LAYER.each.map { |key, tile| "LOW_DECO_LAYER[#{key}] = #{tile.inspect}\n" }.join}
    HI_DECO_LAYER = {}
    #{HI_DECO_LAYER.each.map { |key, tile| "HI_DECO_LAYER[#{key}] = #{tile.inspect}\n" }.join}
  RUBY
end

def interaction_tile(actor)
  x, y = actor.values_at(:x, :y)
  y -= GRID_SIZE.half if actor.level == :stool
  tile_at(x, y, actor.facing)
end

def toggle_interactive(interactive)
  transitions = interactive.transitions || { default: proc { true } }
  new_state = transitions.select { |k, v| v.call }.keys.sample
  set_interactive_state(interactive, new_state) if new_state
end

def set_interactive_state(interactive, new_state)
  return if interactive.current_state == new_state
  $audio[$actor.name] = interactive.sound if interactive.sound
  new_state = new_state.call if new_state.is_a?(Proc)
  interactive.merge!(
    current_state: new_state,
    **interactive.states[new_state],
  )
end

def collisions(object)
  colliders = $actors + $mid.values + $stools.values
  colliders.reject! { |x| x.id == object.id }
  $geometry.find_all_intersect_rect(object, colliders)
end

def try_move(actors, dx, dy)
  unless dx.zero?
    actors.each { |actor| actor.x += dx }
    if (actor, box = actors.filter_map { |actor| collisions(actor).first.then { |box| [actor, box] unless box.nil? } }.first)
      actor_rect = $geometry.rect_props(actor)
      box = $geometry.rect_props(box)
      nx = dx.positive? ? box.x - actor_rect.x - actor_rect.w : box.x + box.w - actor_rect.x
      actors.each { |actor| actor.x += nx }
    end
  end

  unless dy.zero?
    actors.each { |actor| actor.y += dy }
    if (actor, box = actors.filter_map { |actor| collisions(actor).first.then { |box| [actor, box] unless box.nil? } }.first)
      actor_rect = $geometry.rect_props(actor)
      box = $geometry.rect_props(box)
      ny = dy.positive? ? box.y - actor_rect.y - actor_rect.h : box.y + box.h - actor_rect.y
      actors.each { |actor| actor.y += ny }
    end
  end
end

def update_hero
  $actor = $state.hero

  if ($inputs.keyboard.key_down.e || $inputs.controller_one.key_down.a || $inputs.finger_right&.intersect_rect?($inputs.virtual_button_input))
    target_tile = interaction_tile($actor)
    if $state.opportunity.values_at(:x, :y) == target_tile && $state.opportunity[:test].call
      $state.score << $actor.carrying if $actor.carrying
      $actor.carrying = $actor.carrying ? nil : TREATS.select { |_, treat| treat.found == $state.opportunity.location }.keys.sample
      $state.opportunity = nil
    elsif $interactives[interaction_tile($actor)]
      toggle_interactive($interactives[interaction_tile($actor)])
    end
  end

  unless $state.failed
    case $actor.level
    when nil
      hero_on_floor
    when :stool
      hero_on_stool
    when :jump_up, :jump_down
      hero_jumping
    end
  end

  action = $state.hero.action

  if $actor.carrying
    $actor.time_without_contraband = 0
    action = :holding if action == :standing
    action = :carrying if action == :walking
  else
    $actor.time_without_contraband += 1
  end

  hero_sprite = HERO[action][$actor.facing]
  hero_sprite = hero_sprite[($state.failed || $state.tick_count).idiv(10) % hero_sprite.length] if hero_sprite.is_a?(Array)
  $actor.merge(hero_sprite)
end

def hero_on_floor
  dx = $inputs.left_right_perc * 4
  dy = $inputs.up_down_perc * 4

  $used_stool = nil
  $stools.values.each { |obj| obj.pushing = nil }

  fx, fy = case $actor.facing
  when :n then [0, +3]
  when :e then [+3, 0]
  when :s then [0, -3]
  when :w then [-3, 0]
  end

  stool = $geometry.find_intersect_rect($actor.shift_rect(fx, fy), $stools.values)
  if stool && !$state.hero.carrying && ($inputs.keyboard.key_held.shift || $inputs.controller_one.key_held.a)
    $state.hero.action = :leaning_back

    stool.pushing = true
    stool.pushing_since ||= Kernel.tick_count

    dx = 0 if fx.zero? || dx.sign == fx.sign
    dy = 0 if fy.zero? || dy.sign == fy.sign

    $state.hero.facing = dx.nonzero? ? (dx.negative? ? :e : :w) : (dy.negative? ? :n : :s) if dx.nonzero? || dy.nonzero?

    if stool.pushing_since.elapsed?(10) && (dx.nonzero? || dy.nonzero?)
      $state.hero.action = :pulling

      if fy.zero?
        try_move([stool, $state.hero], dx / 6, 0)
      else
        try_move([stool, $state.hero], 0, dy / 6)
      end
    end
  elsif stool && !$state.hero.carrying && (dx * fx > 2 || dy * fy > 2)
    $state.hero.action = :leaning_in

    stool.pushing = true
    stool.pushing_since ||= Kernel.tick_count

    if stool.pushing_since.elapsed?(10)
      $state.hero.action = :pushing

      if fy.zero?
        try_move([stool, $state.hero], dx.quarter, 0)
      else
        try_move([stool, $state.hero], 0, dy.quarter)
      end
    end
  elsif stool && ($inputs.keyboard.key_down.space || $inputs.controller_one.key_down.x)
    $used_stool = stool
    $actor.action = :coiling
    $actor.level = :jump_up
    $actor.started_at = Kernel.tick_count
    $actor.jumping_to = $geometry.rect_props(stool).shift_rect(GRID_SIZE.half, GRID_SIZE.half)
  elsif dx.nonzero? || dy.nonzero?
    $state.hero.action = :walking
    $state.hero.facing = dx.abs > dy.abs ? (dx.positive? ? :e : :w) : (dy.positive? ? :n : :s) if dx.nonzero? || dy.nonzero?
    try_move([$state.hero], dx, dy)
    $state.hero.last_moved = Kernel.tick_count
  else
    $state.hero.action = :standing
  end

  $stools.values.each { |stool| stool.pushing_since = nil unless stool.pushing }
end

def hero_jumping
  return unless $state.hero.started_at.elapsed?(10)

  slow_fast = $args.easing.ease($state.hero.started_at + 10, Kernel.tick_count, 30, proc { |x| x * x })
  fast_slow = $args.easing.ease($state.hero.started_at + 10, Kernel.tick_count, 30, :flip, proc { |x| x * x }, :flip)
  if $state.hero.level == :jump_up
    $state.hero.x = $state.hero.x.lerp($state.hero.jumping_to.x, slow_fast)
    $state.hero.y = $state.hero.y.lerp($state.hero.jumping_to.y, fast_slow)
  else
    $state.hero.x = $state.hero.x.lerp($state.hero.jumping_to.x, fast_slow)
    $state.hero.y = $state.hero.y.lerp($state.hero.jumping_to.y, slow_fast)
  end

  $state.hero.action = :jumping
  $state.hero.anchor_x = 0.5 + ($state.hero.x - $state.hero.jumping_to.x) / $state.hero.w
  $state.hero.anchor_y = 0.0 + ($state.hero.y - $state.hero.jumping_to.y) / $state.hero.h

  if $state.hero.started_at.elapsed?(30)
    $state.hero.level = $state.hero.level == :jump_up ? :stool : nil
    $state.hero.action = :standing
  end
end

def hero_on_stool
  dx = $inputs.left_right_perc
  dy = $inputs.up_down_perc

  if dx.nonzero? || dy.nonzero?
    $state.hero.facing = dx.abs > dy.abs ? (dx.positive? ? :e : :w) : (dy.positive? ? :n : :s)
  end

  fx, fy = case $actor.facing
  when :n then [0, +1]
  when :e then [+1, 0]
  when :s then [0, -1]
  when :w then [-1, 0]
  end

  target = $state.hero.shift_rect(fx * GRID_SIZE, fy * GRID_SIZE.half - GRID_SIZE.half)
  if collisions(target).none? && ($inputs.keyboard.key_down.space || $inputs.controller_one.key_down.x)
    $actor.action = :coiling
    $actor.level = :jump_down
    $actor.started_at = Kernel.tick_count
    $actor.jumping_to = target
  end
end

def update_mommy
  $colliders = [$state.hero, $state.daddy, $used_stool].compact
  update_actor($state.mommy) unless $state.failed

  action = $state.mommy.action
  action = :holding if $actor.carrying && action == :standing
  action = :carrying if $actor.carrying && action == :walking

  mommy_sprite = MOMMY[action][$state.mommy.facing]
  mommy_sprite = mommy_sprite[($state.failed || $state.tick_count).idiv(10) % mommy_sprite.length] if mommy_sprite.is_a?(Array)
  $state.mommy.merge(mommy_sprite)
end

def update_daddy
  $colliders = [$state.hero, $state.mommy, $used_stool].compact
  update_actor($state.daddy) unless $state.failed

  action = $state.daddy.action
  action = :holding if $actor.carrying && action == :standing
  action = :carrying if $actor.carrying && action == :walking

  daddy_sprite = DADDY[action][$state.daddy.facing]
  daddy_sprite = daddy_sprite[($state.failed || $state.tick_count).idiv(10) % daddy_sprite.length] if daddy_sprite.is_a?(Array)
  $state.daddy.merge(daddy_sprite)
end

def available_chores(actor)
  (CHORES.keys - [actor.last_chore])
    .select { |chore| chore == :relax || !$state.in_progress[chore] }
    .select { |chore| CHORES[chore].check.nil? || CHORES[chore].check.call(actor) }
end

def update_actor(actor)
  $actor = actor

  actor.bathroom_timer -= 1

  agenda = actor.agenda
  loop do
    if agenda.empty?
      actor.action = :standing
      chore = available_chores(actor).sample
      return unless chore

      $state.in_progress[chore] = actor
      agenda << { chore: chore, :completed=>[], :current_step=>nil, :action=>0, :action_timer=>0 }
    end

    task = agenda.first
    chore = CHORES[task.chore]
    task.action_timer -= 1

    if task.completed.size == chore.steps.size
      agenda.shift
      actor.last_chore = task.chore
      $state.in_progress[actor.last_chore] = nil
      next
    end

    loop do
      if task.current_step.nil?
        task.current_step ||= :initialize if chore.steps.include?(:initialize) && !task.completed.include?(:initialize)
        task.current_step ||= (chore.steps.keys - task.completed - [:finalize]).sample
        task.current_step ||= :finalize if chore.steps.include?(:finalize) && !task.completed.include?(:finalize)
        break if task.current_step.nil?

        step = chore.steps[task.current_step]
        if step.check && !step.check[actor]
          task.current_step = nil
          next
        end

        task.action = 0
      end

      step = chore.steps[task.current_step]

      action = step.actions[task.action]
      if action.nil?
        task.completed << task.current_step
        task.current_step = nil
        next
      end

      complete = case action.action
      when :move then
        if actor.destination.nil?
          actor.destination = action.slice(:x, :y)
          actor.pathfinding = nil
        end
        move_actor(actor) && actor.merge!(destination: nil, pathfinding: nil, facing: action.facing)
      when :activate then
        set_interactive_state($interactives_by_name[action.interactive], action.state)
        true
      when :wait
        task.action_timer = action.duration if task.action_timer < 0
        actor.action = action.animation
        task.action_timer.zero?
      when :update
        action.executor.call(actor)
        true
      end

      task.action += 1 if complete
      return
    end
  end
end

def move_actor(actor)
  return actor.merge!(path: []) if $geometry.distance_squared(actor.slice(:x, :y), actor.destination) < 16
  recompute_path(actor) if actor.path.empty? || actor.pathfinding || $args.tick_count.zmod?(10)
  return false if actor.path.empty?

  target = actor.path.first
  dx, dy = target.x - actor.x, target.y - actor.y

  actor.action = :walking
  actor.last_moved = Kernel.tick_count
  new_facing = dx.abs > dy.abs ? (dx.positive? ? :e : :w) : (dy.positive? ? :n : :s)
  actor.facing_changed = Kernel.tick_count unless actor.facing == new_facing
  actor.facing = new_facing

  distance = $geometry.distance(actor, target)
  actor.merge!(actor.path.shift.slice(:x, :y)) and return if distance < 3

  step = distance
  step = step.half if actor.path.length == 1
  step = step.cap(3)

  angle = actor.angle_to(target)

  try_move([actor], angle.vector_x(step), angle.vector_y(step))

  if $geometry.distance(actor, target).subtract(distance).abs < 0.002
    alternates = case actor.facing
    when :n then [:e, :w, :s]
    when :w then [:n, :s, :e]
    when :s then [:w, :e, :n]
    when :e then [:s, :n, :w]
    end

    tiles = alternates.map { |facing| tile_at(actor.x, actor.y, facing) }
    tile = tiles.find { |x| $base[x] && !$mid[x] }
    actor.path.unshift(tile.then { |x, y| { x: x * GRID_SIZE, y: y * GRID_SIZE } }) if tile
  end

  actor.last_angle = angle

  return false
end

def recompute_path(actor)
  new_path = actor.path.empty?
  from =
    if new_path
      actor.values_at(:x, :y).map! { |x| x.idiv(GRID_SIZE) }
    else
      actor.path.first.values_at(:x, :y).map! { |x| x.idiv(GRID_SIZE) }
    end
  to = actor.destination.values_at(:x, :y).map! { |x| x.idiv(GRID_SIZE) }
  destination = actor.merge(actor.destination.slice(:x, :y))

  return actor.merge!(path: [destination], pathfinding: nil) if from == to

  unless actor.pathfinding
    node = { pos: from, cost: [0, 0], parent: nil }
    actor.pathfinding = { open: { from => node }, closed: [from] }
  end

  open, closed = actor.pathfinding.values_at(:open, :closed)
  colliders = ($colliders - [actor]).map { |obj| obj.values_at(:x, :y).map! { |x| x.idiv(GRID_SIZE) } }
  stools = $stools.values.map { |obj| obj.values_at(:x, :y).map! { |x| x.idiv(GRID_SIZE) } }

  result = nil
  25.times do
    node = open.values.min { |a, b| a.cost <=> b.cost }
    open.delete(node.pos)
    closed.push node.pos

    break result = node if node.pos == to

    [[1, 0], [0, 1], [0, -1], [-1, 0]].each do |(dx, dy)|
      neighbor = [ node.pos[0] + dx, node.pos[1] + dy ]
      next if $mid.include?(neighbor)
      next if closed.include?(neighbor)

      step = 1
      parent = node
      points_crossed = node.parent && $line_of_sight.dig(node.parent.pos, neighbor)
      if points_crossed && ((colliders | stools) & points_crossed).none? && !colliders.include?(from)
        parent = node.parent
        step = $geometry.distance(parent.pos, neighbor)
      else
        points_crossed = [parent.pos, neighbor]
      end

      step += 50 if (colliders & points_crossed).any?
      step += 20 if (stools & points_crossed).any?

      estimate = $geometry.distance(neighbor, to)
      cost = [parent.cost.last + step + estimate, estimate, parent.cost.last + step]
      if (existing = open[neighbor])
        next unless (cost <=> existing.cost).neg?
        existing.cost = cost
        existing.parent = parent
      else
        open[neighbor] = { pos: neighbor, cost: cost, parent: parent }
      end
    end
  end

  if result
    actor.pathfinding = nil
    actor.path = [result, { pos: to }]
    actor.path.unshift(result = result.parent) while result.parent
    actor.path.shift if new_path
    actor.path.map! { |node| actor.merge(x: node.pos[0] * GRID_SIZE + GRID_SIZE.half, y: node.pos[1] * GRID_SIZE + GRID_SIZE.half) }
    return true
  end
end

OFFSETS = [
  [GRID_SIZE, 0],
  [0, -GRID_SIZE],
  [-GRID_SIZE, 0],
  [0, GRID_SIZE],
]

def self.points_between(from, to)
  x1, y1 = from
  x2, y2 = to

  dx = (x2 - x1).abs
  dy = (y2 - y1).abs

  if dx < dy
    swap = true
    dx, dy = dy, dx
    x1, y1 = y1, x1
    x2, y2 = y2, x2
  end

  sx = (x2 - x1).sign
  sy = (y2 - y1).sign

  points = { from => true }

  e = dx

  dx *= 2
  dy *= 2

  e.times do
    p = e

    x1 += sx
    e += dy

    if e > dx
      y1 += sy
      e -= dx

      if (e + p) <= dx
        point = swap ? [y1 - sy, x1] : [x1, y1 - sy]
        return false if $mid.key?(point)
        points[point] = true
      end

      if (e + p) >= dx
        point = swap ? [y1, x1 - sx] : [x1 - sx, y1]
        return false if $mid.key?(point)
        points[point] = true
      end
    end

    point = swap ? [y1, x1] : [x1, y1]
    return false if $mid.key?(point)
    points[point] = true
  end

  points = points.keys
  return points
end

def line_from(a, b)
  { x: a.x, y: a.y, x2: b.x, y2: b.y }
end

MOMMY_COLOR = { r: 255, g: 100, b: 100 }
DADDY_COLOR = { r: 0, g: 0, b: 200 }
HERO_COLOR = { r: 255, b: 255, g: 100 }

def debug_pathfinding
  $actors.each do |actor|
    color = case actor
    when $state.mommy then MOMMY_COLOR
    when $state.daddy then DADDY_COLOR
    when $state.hero then HERO_COLOR
    end

    $outputs.primitives << actor.dup.solid!(color)

    if actor.destination
      $outputs.primitives << $geometry.rect_props(actor.merge(actor.destination.slice(:x, :y))).solid!(color.merge(a: 200))
      $outputs.primitives << line_from($geometry.rect_props(actor).center, actor.destination).line!(color.merge(a: 200))
    end

    if actor.pathfinding
      $outputs.primitives << actor.pathfinding[:open].values.map { |node| { x: node.pos[0] * GRID_SIZE, y: node.pos[1] * GRID_SIZE, w: GRID_SIZE, h: GRID_SIZE }.to_solid(g: 255, a: 200) }
      $outputs.primitives << actor.pathfinding[:closed].map { |rect| { x: rect[0] * GRID_SIZE, y: rect[1] * GRID_SIZE, w: GRID_SIZE, h: GRID_SIZE }.to_solid(r: 200, a: 100) }

      edges = actor.pathfinding[:open].values
      until edges.empty?
        node = edges.shift
        next unless node.parent

        edges << node.parent
        $outputs.primitives << {
          x: node.pos[0] * GRID_SIZE + GRID_SIZE.half,
          y: node.pos[1] * GRID_SIZE + GRID_SIZE.half,
          x2: node.parent.pos[0] * GRID_SIZE + GRID_SIZE.half,
          y2: node.parent.pos[1] * GRID_SIZE + GRID_SIZE.half
        }.to_line(b: 255)
      end

      $outputs.primitives << actor.pathfinding[:open].values.map do |node|
        props = $geometry.rect_props({ x: node.pos[0] * GRID_SIZE, y: node.pos[1] * GRID_SIZE, w: GRID_SIZE, h: GRID_SIZE })
        [
          props.to_label(text: "f: " + node.cost[0].to_sf, size_enum: -7.5, anchor_y: -3.5).then { |x| [ x.shift_rect(0.5, -1).merge(r: 255, g: 255, b:255), x ]},
          props.to_label(text: "g: " + node.cost[2].to_sf, size_enum: -7.5, anchor_y: -2.5).then { |x| [ x.shift_rect(0.5, -1).merge(r: 255, g: 255, b:255), x ]},
          props.to_label(text: "h: " + node.cost[1].to_sf, size_enum: -7.5, anchor_y: -1.5).then { |x| [ x.shift_rect(0.5, -1).merge(r: 255, g: 255, b:255), x ]},
        ]
      end
    end

    if actor.path
      points = [$geometry.rect_props(actor), *actor.path.map { |rect| $geometry.rect_props(actor.merge(rect)) }]
      $outputs.primitives << points.each_cons(2).map do |a, b|
        [
          line_from(a, b).line!(color),
          line_from(a.shift_rect(actor.w, 0), b.shift_rect(actor.w, 0)).line!(color),
          line_from(a.shift_rect(0, actor.h), b.shift_rect(0, actor.h)).line!(color),
          line_from(a.shift_rect(actor.w, actor.h), b.shift_rect(actor.w, actor.h)).line!(color),
          line_from(a.center, b.center).line!
        ]
      end
    end
  end

  # $outputs.primitives << $mid.values.map { |x| x.merge(g: 255, a: 250).solid! }
  # $outputs.primitives << $stools.values.map { |x| x.merge(b: 255, a: 250).solid! }
  # $outputs.primitives << $actors.map { |x| x.merge(a: 250).solid! }
end
