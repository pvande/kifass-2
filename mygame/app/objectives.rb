# chores -> steps -> tasks -> actions
CHORES = {
  bathroom: {
    check: proc { |actor| actor.bathroom_timer < 0 },
    steps: {
      use_bathroom: {
        actions: [
          { action: :move, x: 590, y: -60, facing: :w },
          { action: :wait, animation: :standing, duration: 4.seconds },
          { action: :move, x: 590, y: 64, facing: :e },
          { action: :activate, interactive: :bathroom_sink, state: :running },
          { action: :wait, animation: :washing, duration: 150 },
          { action: :activate, interactive: :bathroom_sink, state: :default },
        ],
      },
      finalize: {
        actions: [
          { action: :update, executor: proc { |actor| actor.bathroom_timer = 30.seconds } },
          { action: :wait, animation: :washing, duration: 20 },
        ],
      },
    },
  },
  start_soup: {
    check: proc { |actor| $state.timers.soup < 0 && $state.stove.carrying.nil? },
    steps: {
      initialize: {
        actions: [
          { action: :move, x: 144, y: 600, facing: :n },
          { action: :activate, interactive: :stove_left_cupboard, state: :open },
          { action: :wait, animation: :washing, duration: 20 },
          { action: :update, executor: proc { |actor| actor.carrying = :empty_pot } },
          { action: :activate, interactive: :stove_left_cupboard, state: :default },
          { action: :move, x: 240, y: 600, facing: :n },
          { action: :update, executor: proc { |actor| actor.carrying, $state.stove.carrying = nil, :empty_pot } },
          { action: :update, executor: proc { $state.timers.soup = 20.seconds } },
        ],
      },
      add_broth: {
        actions: [
          { action: :move, x: 370, y: 600, facing: :n },
          { action: :activate, interactive: :pantry, state: :lower },
          { action: :wait, animation: :washing, duration: 20 },
          { action: :activate, interactive: :pantry, state: :default },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :activate, interactive: :stove, state: :stovetop },
          { action: :wait, animation: :washing, duration: 1.seconds },
          { action: :update, executor: proc { $state.stove.carrying = :pot_of_soup } },
        ],
      },
      add_veg: {
        actions: [
          { action: :move, x: 342, y: 600, facing: :n },
          { action: :activate, interactive: :fridge, state: :fridge },
          { action: :wait, animation: :washing, duration: 30 },
          { action: :activate, interactive: :fridge, state: :default },
          { action: :move, x: 174, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 2.seconds },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :activate, interactive: :stove, state: :stovetop },
          { action: :wait, animation: :washing, duration: 1.seconds },
          { action: :update, executor: proc { $state.stove.carrying = :pot_of_soup } },
        ],
      },
      add_meat: {
        actions: [
          { action: :move, x: 342, y: 600, facing: :n },
          { action: :activate, interactive: :fridge, state: :fridge },
          { action: :wait, animation: :washing, duration: 30 },
          { action: :activate, interactive: :fridge, state: :default },
          { action: :move, x: 174, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 2.seconds },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :activate, interactive: :stove, state: :stovetop },
          { action: :wait, animation: :washing, duration: 1.seconds },
          { action: :update, executor: proc { $state.stove.carrying = :pot_of_soup } },
        ],
      },
      add_roots: {
        actions: [
          { action: :move, x: 106, y: 584, facing: :w },
          { action: :activate, interactive: :sink_double_cupboard, state: :open },
          { action: :wait, animation: :washing, duration: 30 },
          { action: :activate, interactive: :sink_double_cupboard, state: :default },
          { action: :move, x: 174, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 2.seconds },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :activate, interactive: :stove, state: :stovetop },
          { action: :wait, animation: :washing, duration: 1.seconds },
          { action: :update, executor: proc { $state.stove.carrying = :pot_of_soup } },
        ],
      },
      season1: {
        actions: [
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :activate, interactive: :stove, state: :stovetop },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 212, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 40 },
        ],
      },
      season2: {
        actions: [
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :activate, interactive: :stove, state: :stovetop },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 212, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 40 },
        ],
      },
      season3: {
        actions: [
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :activate, interactive: :stove, state: :stovetop },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 212, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 40 },
        ],
      },
    },
  },
  cook_soup: {
    check: proc { $state.stove.carrying },
    steps: {
      add_veg: {
        actions: [
          { action: :move, x: 342, y: 600, facing: :n },
          { action: :activate, interactive: :fridge, state: :fridge },
          { action: :wait, animation: :washing, duration: 30 },
          { action: :activate, interactive: :fridge, state: :default },
          { action: :move, x: 174, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 2.seconds },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 1.seconds },
        ],
      },
      add_meat: {
        actions: [
          { action: :move, x: 342, y: 600, facing: :n },
          { action: :activate, interactive: :fridge, state: :fridge },
          { action: :wait, animation: :washing, duration: 30 },
          { action: :activate, interactive: :fridge, state: :default },
          { action: :move, x: 174, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 2.seconds },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 1.seconds },
        ],
      },
      add_roots: {
        actions: [
          { action: :move, x: 106, y: 584, facing: :w },
          { action: :activate, interactive: :sink_double_cupboard, state: :open },
          { action: :wait, animation: :washing, duration: 30 },
          { action: :activate, interactive: :sink_double_cupboard, state: :default },
          { action: :move, x: 174, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 2.seconds },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 1.seconds },
        ],
      },
      season1: {
        actions: [
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 212, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 40 },
        ],
      },
      season2: {
        actions: [
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 212, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 40 },
        ],
      },
      season3: {
        actions: [
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 212, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :move, x: 244, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 40 },
        ],
      },
    },
  },
  starting_bread: {
    check: proc { $state.timers.dough.nil? && $state.timers.oven < 60.seconds },
    steps: {
      gather_flour: {
        actions: [
          { action: :move, x: 106, y: 600, facing: :n },
          { action: :activate, interactive: :flour_bin, state: :open },
          { action: :wait, animation: :washing, duration: 20 },
          { action: :activate, interactive: :flour_bin, state: :default },
          { action: :move, x: 300, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 20 },
        ]
      },
      gather_water: {
        actions: [
          { action: :move, x: 342, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 60 },
          { action: :move, x: 300, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 20 },
        ]
      },
      gather_yeast: {
        actions: [
          { action: :move, x: 338, y: 600, facing: :n },
          { action: :activate, interactive: :fridge, state: :fridge },
          { action: :wait, animation: :washing, duration: 20 },
          { action: :activate, interactive: :fridge, state: :default },
          { action: :move, x: 300, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 10 },
        ]
      },
      finalize: {
        actions: [
          { action: :move, x: 300, y: 600, facing: :n },
          { action: :wait, animation: :standing, duration: 1.seconds },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :wait, animation: :standing, duration: 2.seconds },
          { action: :wait, animation: :washing, duration: 10 },
          { action: :update, executor: proc { $state.timers.dough = 60.seconds } },
        ],
      },
    },
  },
  baking_bread: {
    check: proc { $state.timers.dough && $state.timers.dough < 0 && $state.timers.oven < 0 },
    steps: {
      initialize: {
        actions: [
          { action: :move, x: 240, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 10 },
        ],
      },
      shape_loaf: {
        actions: [
          { action: :move, x: 300, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 40 },
        ]
      },
      finalize: {
        actions: [
          { action: :move, x: 240, y: 600, facing: :n },
          { action: :activate, interactive: :stove, state: :oven },
          { action: :wait, animation: :washing, duration: 20 },
          { action: :activate, interactive: :stove, state: proc { $state.stove.carrying ? :stovetop : :default } },
          { action: :update, executor: proc { $state.in_use[:oven] = $state.timers.oven = 30.seconds } },
        ],
      },
    },
  },
  remove_from_oven: {
    check: proc { $state.in_use[:oven] && $state.timers.oven < 0 },
    steps: {
      finalize: {
        actions: [
          { action: :move, x: 240, y: 600, facing: :n },
          { action: :activate, interactive: :stove, state: :oven },
          { action: :wait, animation: :washing, duration: 20 },
          { action: :activate, interactive: :stove, state: :default },
        ],
      },
    },
  },
  washing_dishes: {
    check: proc { $state.timers.dishes < 0 },
    steps: {
      hand_washing: {
        actions: [
          { action: :move, x: 106, y: 548, facing: :w },
          { action: :activate, interactive: :kitchen_sink, state: :running },
          { action: :wait, animation: :washing, duration: 150 },
          { action: :activate, interactive: :kitchen_sink, state: :default },
        ],
      },
      loading_1: {
        actions: [
          { action: :move, x: 106, y: 548, facing: :w },
          { action: :wait, animation: :washing, duration: 20 },
          { action: :move, x: 106, y: 520, facing: :w },
          { action: :activate, interactive: :dishwasher, state: :open },
          { action: :wait, animation: :washing, duration: 20 },
        ],
      },
      loading_2: {
        actions: [
          { action: :move, x: 106, y: 548, facing: :w },
          { action: :wait, animation: :washing, duration: 20 },
          { action: :move, x: 106, y: 520, facing: :w },
          { action: :activate, interactive: :dishwasher, state: :open },
          { action: :wait, animation: :washing, duration: 20 },
        ],
      },
      loading_3: {
        actions: [
          { action: :move, x: 106, y: 488, facing: :w },
          { action: :wait, animation: :washing, duration: 20 },
          { action: :move, x: 106, y: 520, facing: :w },
          { action: :activate, interactive: :dishwasher, state: :open },
          { action: :wait, animation: :washing, duration: 20 },
        ],
      },
      finalize: {
        actions: [
          { action: :move, x: 106, y: 520, facing: :w },
          { action: :activate, interactive: :dishwasher, state: :default },
          { action: :update, executor: proc { $state.timers.dishes = 60.seconds } },
        ],
      },
    },
  },
  trash: {
    check: proc { $state.timers.trash < 0 },
    steps: {
      kid_trash: {
        actions: [
          { action: :move, x: 1174, y: 296, facing: :e },
          { action: :wait, animation: :washing, duration: 60 },
          { action: :update, executor: proc { |actor| actor.carrying = :garbage } },
        ],
      },
      adult_trash: {
        actions: [
          { action: :move, x: 810, y: 136, facing: :w },
          { action: :wait, animation: :washing, duration: 60 },
          { action: :update, executor: proc { |actor| actor.carrying = :garbage } },
        ],
      },
      kitchen_trash: {
        actions: [
          { action: :move, x: 106, y: 392, facing: :w },
          { action: :wait, animation: :washing, duration: 60 },
          { action: :update, executor: proc { |actor| actor.carrying = :garbage } },
        ],
      },
      commons_trash: {
        actions: [
          { action: :move, x: 590, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 60 },
          { action: :update, executor: proc { |actor| actor.carrying = :garbage } },
        ],
      },
      finalize: {
        actions: [
          { action: :move, x: 438, y: 728, facing: :n },
          { action: :wait, animation: :washing, duration: 20.seconds },
          { action: :update, executor: proc { |actor| actor.carrying = nil } },
          { action: :update, executor: proc { |actor| $state.timers.trash = 60.seconds } },
        ],
      },
    },
  },
  make_kid_bed: {
    check: proc { $state.timers.trash < 0 },
    steps: {
      finalize: {
        actions: [
          { action: :move, x: 1134, y: 600, facing: :n },
          { action: :wait, animation: :washing, duration: 60 },
        ],
      },
    },
  },
  doorbell: {
    check: proc { rand(5).zero? },
    steps: {
      initialize: {
        actions: [
          { action: :update, executor: proc { |actor| $audio[actor.name] = { input: "sounds/doorbell.wav", gain: 0.6 } } },
          { action: :move, x: 959, y: 696, facing: :n },
          { action: :wait, animation: :washing, duration: 30 + rand(10) },
        ],
      },
      convo1: {
        actions: [
          { action: :wait, animation: :washing, duration: 30 + rand(5) * 10 },
          { action: :wait, animation: :standing, duration: 30 + rand(2) * 8 },
        ],
      },
      convo2: {
        actions: [
          { action: :wait, animation: :washing, duration: 20 + rand(5) * 10 },
          { action: :wait, animation: :standing, duration: 20 + rand(2) * 8 },
        ],
      },
      convo3: {
        actions: [
          { action: :wait, animation: :washing, duration: 10 + rand(5) * 10 },
          { action: :wait, animation: :standing, duration: 10 + rand(2) * 8 },
        ],
      },
      finalize: {
        actions: [
          { action: :update, executor: proc { |actor| $audio[actor.name] = { input: "sounds/door.wav", gain: 0.6 } } },
        ],
      },
    },
  },
  relax: {
    steps: {
      seat1: {
        check: proc { !$state.couch.include?(1) },
        actions: [
          { action: :update, executor: proc { ($state.couch ||= []) << 1 } },
          { action: :move, x: 624, y: 600, facing: :s },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 5 } },
          { action: :wait, animation: :standing, duration: 5.seconds },
          {
            action: :update,
            executor: proc do |actor|
              if available_chores(actor).any? { |chore| chore != :relax }
                $state.couch.delete(1)
                actor.agenda.first.merge!(completed: CHORES[:relax].steps.keys - [:finalize], current_step: nil, action: 0)
              else
                actor.agenda.first.merge!(action: 4, duration: 15)
              end
            end,
          },
        ],
      },
      seat2: {
        check: proc { !$state.couch.include?(2) },
        actions: [
          { action: :update, executor: proc { ($state.couch ||= []) << 2 } },
          { action: :move, x: 656, y: 600, facing: :s },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 5 } },
          { action: :wait, animation: :standing, duration: 5.seconds },
          {
            action: :update,
            executor: proc do |actor|
              if available_chores(actor).any? { |chore| chore != :relax }
                $state.couch.delete(2)
                actor.agenda.first.merge!(completed: CHORES[:relax].steps.keys - [:finalize], current_step: nil, action: 0)
              else
                actor.agenda.first.merge!(action: 4, duration: 15)
              end
            end,
          },
        ],
      },
      seat3: {
        check: proc { !$state.couch.include?(3) },
        actions: [
          { action: :update, executor: proc { ($state.couch ||= []) << 3 } },
          { action: :move, x: 688, y: 600, facing: :s },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 5 } },
          { action: :wait, animation: :standing, duration: 5.seconds },
          {
            action: :update,
            executor: proc do |actor|
              if available_chores(actor).any? { |chore| chore != :relax }
                $state.couch.delete(3)
                actor.agenda.first.merge!(completed: CHORES[:relax].steps.keys - [:finalize], current_step: nil, action: 0)
              else
                actor.agenda.first.merge!(action: 4, duration: 15)
              end
            end,
          },
        ],
      },
      seat4: {
        check: proc { !$state.couch.include?(4) },
        actions: [
          { action: :update, executor: proc { ($state.couch ||= []) << 4 } },
          { action: :move, x: 720, y: 600, facing: :s },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 5 } },
          { action: :wait, animation: :standing, duration: 5.seconds },
          {
            action: :update,
            executor: proc do |actor|
              if available_chores(actor).any? { |chore| chore != :relax }
                $state.couch.delete(4)
                actor.agenda.first.merge!(completed: CHORES[:relax].steps.keys - [:finalize], current_step: nil, action: 0)
              else
                actor.agenda.first.merge!(action: 4, duration: 15)
              end
            end,
          },
        ],
      },
      seat5: {
        check: proc { !$state.couch.include?(5) },
        actions: [
          { action: :update, executor: proc { ($state.couch ||= []) << 5 } },
          { action: :move, x: 752, y: 600, facing: :s },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 5 } },
          { action: :wait, animation: :standing, duration: 5.seconds },
          {
            action: :update,
            executor: proc do |actor|
              if available_chores(actor).any? { |chore| chore != :relax }
                $state.couch.delete(5)
                actor.agenda.first.merge!(completed: CHORES[:relax].steps.keys - [:finalize], current_step: nil, action: 0)
              else
                actor.agenda.first.merge!(action: 4, duration: 15)
              end
            end,
          },
        ],
      },
      seat6: {
        check: proc { !$state.couch.include?(6) },
        actions: [
          { action: :update, executor: proc { ($state.couch ||= []) << 6 } },
          { action: :move, x: 784, y: 600, facing: :s },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 5 } },
          { action: :wait, animation: :standing, duration: 5.seconds },
          {
            action: :update,
            executor: proc do |actor|
              if available_chores(actor).any? { |chore| chore != :relax }
                $state.couch.delete(6)
                actor.agenda.first.merge!(completed: CHORES[:relax].steps.keys - [:finalize], current_step: nil, action: 0)
              else
                actor.agenda.first.merge!(action: 4, duration: 15)
              end
            end,
          },
        ],
      },
      seat7: {
        check: proc { !$state.couch.include?(7) },
        actions: [
          { action: :update, executor: proc { ($state.couch ||= []) << 7 } },
          { action: :move, x: 1142, y: 120, facing: :s },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 5 } },
          { action: :wait, animation: :standing, duration: 5.seconds },
          {
            action: :update,
            executor: proc do |actor|
              if available_chores(actor).any? { |chore| chore != :relax }
                $state.couch.delete(7)
                actor.agenda.first.merge!(completed: CHORES[:relax].steps.keys - [:finalize], current_step: nil, action: 0)
              else
                actor.agenda.first.merge!(action: 4, duration: 15)
              end
            end,
          },
        ],
      },
      seat8: {
        check: proc { !$state.couch.include?(8) },
        actions: [
          { action: :update, executor: proc { ($state.couch ||= []) << 8 } },
          { action: :move, x: 1170, y: 120, facing: :s },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 4 } },
          { action: :update, executor: proc { |actor| actor.y += 5 } },
          { action: :wait, animation: :standing, duration: 5.seconds },
          {
            action: :update,
            executor: proc do |actor|
              if available_chores(actor).any? { |chore| chore != :relax }
                $state.couch.delete(8)
                actor.agenda.first.merge!(completed: CHORES[:relax].steps.keys - [:finalize], current_step: nil, action: 0)
              else
                actor.agenda.first.merge!(action: 4, duration: 15)
              end
            end,
          },
        ],
      },
      finalize: {
        actions: [
          { action: :update, executor: proc { |actor| actor.y -= 5 } },
          { action: :update, executor: proc { |actor| actor.y -= 4 } },
          { action: :update, executor: proc { |actor| actor.y -= 4 } },
        ],
      },
    },
  },
}
