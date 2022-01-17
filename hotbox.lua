-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_hot.png^[mask:nc_api_storebox_frame.png"

local side = "nc_lode_hot.png^(" .. form .. ")"

local hotstuff = "nc_terrain_lava.png^[verticalframe:32:8"

local top = "(" .. hotstuff .. ")^(" .. form .. ")"
	
minetest.register_node(modname .. ":shelf_cauldron_pumwater", {
		description = "Scorching Lode Cauldron",
		tiles = {top, side, side},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 4,
			totable = 1,
			scaling_time = 50,
			lux_emit = 1,
			igniter = 1
		},
		paramtype = "light",
		light_source = 4,
		sounds = nodecore.sounds("nc_lode_tempered"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
	})

nodecore.register_craft({
		label = "assemble scorching cauldron",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_cauldron_tempered"},
		wield = {name = "nc_igneous:amalgam"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_cauldron_tempered", empty = true},
				replace = modname .. ":shelf_cauldron_pumwater"
			},
		}
	})
