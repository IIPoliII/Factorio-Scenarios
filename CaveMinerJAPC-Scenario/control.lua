require "utils.utils"
require "utils.corpse_util"
require "bot"
require "chatbot"
require "session_tracker"
require "antigrief"
require "antigrief_admin_panel"
require "group"
require "player_list"
require "poll"
require "score"

---- enable modules here ----
--require "maps.tools.map_pregen"
require "maps.tools.cheat_mode"
require "maps.modules.hunger"
require "maps.modules.fish_respawner"
--require "maps.modules.rocket_launch_always_yields_science"
--require "maps.modules.launch_10000_fish_to_win"
--require "maps.modules.dynamic_landfill"
--require "maps.modules.restrictive_fluid_mining"
--require "maps.modules.fluids_are_explosive"
require "maps.modules.explosives_are_explosive"
--require "maps.modules.explosive_biters"
--require "maps.modules.teleporting_worms"
require "maps.modules.railgun_enhancer"
-----------------------------

---- enable maps here ----
--require "maps.biter_battles"
require "maps.cave_miner"
--require "maps.labyrinth"
--require "maps.spooky_forest"
--require "maps.nightfall"
--require "maps.atoll"
--require "maps.tank_battles"
--require "maps.spiral_troopers"
--require "maps.fish_defender"
--require "maps.crossing"
--require "maps.anarchy"
--require "maps.spaghettorio"
--require "maps.deep_jungle"
--require "maps.lost_desert"
--require "maps.empty_map"
--require "maps.custom_start"
-----------------------------

local Event = require 'utils.event'

local function on_player_created(event)	
	local player = game.players[event.player_index]	
	player.gui.top.style = 'slot_table_spacing_horizontal_flow'
	player.gui.left.style = 'slot_table_spacing_vertical_flow'
end

function spaghetti()
	game.forces["player"].technologies["logistic-system"].enabled = false
	game.forces["player"].technologies["construction-robotics"].enabled = false
	game.forces["player"].technologies["logistic-robotics"].enabled = false
	game.forces["player"].technologies["robotics"].enabled = false
	game.forces["player"].technologies["personal-roboport-equipment"].enabled = false
	game.forces["player"].technologies["personal-roboport-equipment-2"].enabled = false
	game.forces["player"].technologies["character-logistic-trash-slots-1"].enabled = false
	game.forces["player"].technologies["character-logistic-trash-slots-2"].enabled = false
	game.forces["player"].technologies["auto-character-logistic-trash-slots"].enabled = false
	game.forces["player"].technologies["worker-robots-storage-1"].enabled = false
	game.forces["player"].technologies["worker-robots-storage-2"].enabled = false
	game.forces["player"].technologies["worker-robots-storage-3"].enabled = false	
	game.forces["player"].technologies["character-logistic-slots-1"].enabled = false
	game.forces["player"].technologies["character-logistic-slots-2"].enabled = false
	game.forces["player"].technologies["character-logistic-slots-3"].enabled = false
	game.forces["player"].technologies["character-logistic-slots-4"].enabled = false
	game.forces["player"].technologies["character-logistic-slots-5"].enabled = false
	game.forces["player"].technologies["character-logistic-slots-6"].enabled = false
	game.forces["player"].technologies["worker-robots-speed-1"].enabled = false
	game.forces["player"].technologies["worker-robots-speed-2"].enabled = false
	game.forces["player"].technologies["worker-robots-speed-3"].enabled = false
	game.forces["player"].technologies["worker-robots-speed-4"].enabled = false
	game.forces["player"].technologies["worker-robots-speed-5"].enabled = false
	game.forces["player"].technologies["worker-robots-speed-6"].enabled = false
end

Event.add(defines.events.on_player_created, on_player_created)