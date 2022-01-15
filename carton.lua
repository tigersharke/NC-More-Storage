-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_tree_tree_top.png^[mask:nc_api_storebox_frame.png"

local side = "nc_flora_thatch.png^nc_tree_eggcorn.png^[colorize:gray:125^(" .. form .. ")"

local bottom = "nc_flora_thatch.png^[colorize:gray:125^(" .. form .. ")"

local knob = "nc_tree_tree_side.png^[mask:" ..modname.. "_knob_mask.png"

local lid = "nc_flora_thatch.png^[colorize:gray:125^(" .. form .. ")^(" .. knob .. ")"

minetest.register_node(modname .. ":shelf_egg", {
		description = "Open Egg Carton",
		tiles = {side, bottom, form,},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 2,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_terrain_swishy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_egg" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble egg carton",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_thatch"},
		wield = {name = "nc_tree:eggcorn"},
		consumewield = 12,	--for some reason this allows it to be crafted with 1-12 eggcorns instead of requiring 12
		nodes = {
			{
				match = {name = "wc_storage:shelf_thatch", empty = true},
				replace = {name = modname .. ":shelf_egg"}
			},
		}
	})

minetest.register_node(modname .. ":shelf_egg_lid", {
		description = "Closed Egg Carton",
		tiles = {side, side, lid},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 2,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_terrain_swishy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_egg_lid" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "open egg carton",
		action = "pummel",
		indexkeys = {modname.. ":shelf_egg_lid"},
		nodes = {
			{
				match = {name = modname.. ":shelf_egg_lid", empty = true}, --must be empty or else item gets deleted
				replace = modname .. ":shelf_egg"
			},
		},
	})
nodecore.register_craft({
		label = "close egg carton",
		action = "pummel",
		indexkeys = {modname.. ":shelf_egg"},
		nodes = {
			{
				match = {name = modname.. ":shelf_egg", empty = true}, --must be empty or else item gets deleted
				replace = modname .. ":shelf_egg_lid"
			},
		},
	})
