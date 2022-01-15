-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local bark = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"

local wick = "nc_flora_wicker.png^(" .. bark .. ")"

local side = "(" ..wick.. ")^(" .. bark .. ")"

minetest.register_node(modname .. ":shelf_fruit", {
		description = "Fruit Basket",
		tiles = {wick, wick, bark},
		color = "plum",
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 2,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 50,
			lux_absorb = 4
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_sticky"),
		storebox_access = function(pt) return pt.above.y == pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_fruit" then
				return nodecore.stack_get(pos)
			end
		end
	})
	

nodecore.register_craft({
		label = "assemble fruit shelf",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_wicker_basket"},
		wield = {name = "wc_plumbum:drupe"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_wicker_basket", empty = true},
				replace = modname .. ":shelf_fruit"
			},
		}
	})

