-- Map by Kyte & MewMew

require "maps.wave_of_death.intro"
require "modules.biter_evasion_hp_increaser"
require "modules.custom_death_messages"
require "modules.dangerous_goods"
require "modules.floaty_chat"

local event = require 'utils.event'
require 'utils.table'
local init = require "maps.wave_of_death.init"
local on_chunk_generated = require "maps.wave_of_death.terrain"
local ai = require "maps.wave_of_death.ai"
local game_status = require "maps.wave_of_death.game_status"

function soft_teleport(player, destination)
	local surface = game.surfaces["wave_of_death"]
	local pos = surface.find_non_colliding_position("character", destination, 8, 0.5)
	if not pos then player.teleport(destination, surface) end
	player.teleport(pos, surface)
end

local function spectate_button(player)
	if player.gui.top.spectate_button then return end
	local button = player.gui.top.add({type = "button", name = "spectate_button", caption = "Spectate"})
	button.style.font = "default-bold"
	button.style.font_color = {r = 0.0, g = 0.0, b = 0.0}
	button.style.minimal_height = 38
	button.style.minimal_width = 38
	button.style.top_padding = 2
	button.style.left_padding = 4
	button.style.right_padding = 4
	button.style.bottom_padding = 2
end

local function create_spectate_confirmation(player)
	if player.gui.center.spectate_confirmation_frame then return end
	local frame = player.gui.center.add({type = "frame", name = "spectate_confirmation_frame", caption = "Are you sure you want to spectate? This can not be undone."})
	frame.style.font = "default"
	frame.style.font_color = {r = 0.3, g = 0.65, b = 0.3}
	frame.add({type = "button", name = "confirm_spectate", caption = "Spectate"})
	frame.add({type = "button", name = "cancel_spectate", caption = "Cancel"})
end

local function autojoin_lane(player)
	local lowest_player_count = 256
	local lane_number
	local lane_numbers = {1,2,3,4}
	table.shuffle_table(lane_numbers)
		
	for _, number in pairs(lane_numbers) do
		if #game.forces[number].connected_players < lowest_player_count and global.wod_lane[number].game_lost == false then
			lowest_player_count = #game.forces[number].connected_players
			lane_number = number
		end
	end
	
	player.force = game.forces[lane_number]
	soft_teleport(player, game.forces[player.force.name].get_spawn_position(game.surfaces["wave_of_death"]))
	player.insert({name = "pistol", count = 1})
	player.insert({name = "firearm-magazine", count = 16})
	player.insert({name = "iron-plate", count = 128})
	player.insert({name = "iron-gear-wheel", count = 32})
end

local function on_player_joined_game(event)
	init()
		
	local player = game.players[event.player_index]
	spectate_button(player)
	if player.online_time == 0 then autojoin_lane(player) return end
	
	if global.wod_lane[tonumber(player.force.name)].game_lost == true then
		player.character.die()
	end
end

local function on_entity_damaged(event)
	ai.prevent_friendly_fire(event)
end

local function on_entity_died(event)
	if not event.entity.valid then return end
	ai.spawn_spread_wave(event)
	game_status.has_lane_lost(event)
end

local function on_player_rotated_entity(event)
	ai.trigger_new_wave(event)
end

local function on_tick(event)
	if game.tick % 300 ~= 0 then return end
	
	for i = 1, 4, 1 do
		game.forces[i].chart(game.surfaces["wave_of_death"], {{-288, -420}, {352, 64}})
	end
	
	game_status.restart_server()
end

local function on_gui_click(event)
	if not event then return end
	if not event.element then return end
	if not event.element.valid then return end
	local player = game.players[event.element.player_index]
	if event.element.name == "cancel_spectate" then player.gui.center["spectate_confirmation_frame"].destroy() return end
	if event.element.name == "confirm_spectate" then
		player.gui.center["spectate_confirmation_frame"].destroy()
		game.permissions.get_group("spectator").add_player(player)
		if player.force.name == "player" then return end
		player.force = game.forces.player
		if player.character then player.character.die() end
		return 
	end
	if event.element.name == "spectate_button" then
		if player.gui.center["spectate_confirmation_frame"] then
			player.gui.center["spectate_confirmation_frame"].destroy()
		else
			create_spectate_confirmation(player)
		end
		return
	end
end

event.add(defines.events.on_gui_click, on_gui_click)
event.add(defines.events.on_tick, on_tick)
event.add(defines.events.on_chunk_generated, on_chunk_generated)
event.add(defines.events.on_entity_damaged, on_entity_damaged)
event.add(defines.events.on_entity_died, on_entity_died)
event.add(defines.events.on_player_joined_game, on_player_joined_game)
event.add(defines.events.on_player_rotated_entity, on_player_rotated_entity)
