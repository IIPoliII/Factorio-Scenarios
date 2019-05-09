local event = require 'utils.event'

--local function trigger_function(schedule)
--	if not schedule.args then schedule.func() return end
--	if not schedule.args[2] then schedule.func(schedule.args[1]) return end
--	if not schedule.args[3] then schedule.func(schedule.args[1], schedule.args[2]) return end
--	if not schedule.args[4] then schedule.func(schedule.args[1], schedule.args[2], schedule.args[3]) return end
--	if not schedule.args[5] then schedule.func(schedule.args[1], schedule.args[2], schedule.args[3], schedule.args[4]) return end
--	if schedule.args[5] then schedule.func(schedule.args[1], schedule.args[2], schedule.args[3], schedule.args[4], schedule.args[5]) return end		
--end

local function on_tick()	
	if not global.on_tick_schedule[game.tick] then return end	
	for _, schedule in pairs(global.on_tick_schedule[game.tick]) do
		schedule.func(unpack(schedule.args))		
	end		
	global.on_tick_schedule[game.tick] = nil
end

local function on_init(event)
	if not global.on_tick_schedule then global.on_tick_schedule = {} end
end

event.on_init(on_init)
event.add(defines.events.on_tick, on_tick)