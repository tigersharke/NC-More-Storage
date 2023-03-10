-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local bark = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"

local bamboo = "(wc_naturae_bamboo_dead.png)^(" .. bark .. ")"

minetest.register_node(modname .. ":shelf_bamboo_basket", {
		description = "Bamboo Basket",
		tiles = {bamboo, bamboo, bark},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			choppy = 2,
			visinv = 1,
			flammable = 2,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_sticky"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_bamboo" then
				return nodecore.stack_get(pos)
			end
		end
	})
	
minetest.register_node(modname .. ":shelf_bamboo", {
		description = "Bamboo Shelf",
		tiles = {bark, bamboo},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			choppy = 2,
			visinv = 1,
			flammable = 2,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_sticky"),
		storebox_access = function(pt) return pt.above.y == pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_bamboo" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble bamboo shelf",
		action = "stackapply",
		indexkeys = {"nc_woodwork:form"},
		wield = {name = "wc_naturae:bamboo_dead_2"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_woodwork:form", empty = true},
				replace = modname .. ":shelf_bamboo"
			},
		}
	})
	
nodecore.register_craft({
		label = "assemble bamboo basket",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_bamboo"},
		wield = {name = "wc_naturae:bamboo_dead_2"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_bamboo", empty = true},
				replace = modname .. ":shelf_bamboo_basket"
			},
		}
	})
