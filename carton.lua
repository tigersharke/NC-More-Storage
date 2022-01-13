-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local bark = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"

local wick = "nc_flora_thatch.png^(nc_tree_eggcorn.png^[colorize:gray:100)^(" .. bark .. ")"

minetest.register_node(modname .. ":shelf_egg", {
		description = "Egg Carton",
--		tiles = {bark, wick},
		tiles = {wick, wick, bark},
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
		indexkeys = {"nc_woodwork:form"},
		wield = {name = "nc_tree:eggcorn"},
		consumewield = 12,
		nodes = {
			{
				match = {name = "nc_woodwork:form", empty = true},
				replace = {name = modname .. ":shelf_egg", count = 12}
			},
		}
	})
