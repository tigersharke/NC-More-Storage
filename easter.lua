-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local bark = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"

local bloom = "(nc_flora_flower_color.png^[mask:nc_flora_flower_5_base.png)^(nc_flora_flower_color.png^[colorize:pink^[mask:nc_flora_flower_5_top.png)"

local side = "nc_tree_bud_top.png^(nc_tree_eggcorn.png^[resize:8x8)^(" ..bloom.. ")^(" .. bark .. ")"

local bottom = "nc_tree_bud_top.png^(" .. bark .. ")"

minetest.register_node(modname .. ":shelf_easter", {
		description = "Easter Egg Basket",
		tiles = {side, bottom, bark},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 3,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_terrain_swishy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_easter" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble easter egg basket",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_floral"},
		wield = {name = "nc_tree:eggcorn"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_floral", empty = true},
				replace = modname .. ":shelf_easter"
			},
		}
	})
