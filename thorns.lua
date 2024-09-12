-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local bark = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"

local thorn = "wc_naturae_thornbriar.png^(" .. bark .. ")"

minetest.register_node(modname .. ":shelf_thorns", {
		description = "Thorny Basket",
		tiles = {thorn, thorn, bark},
		color = "lightslategray",
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 2,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			basketable = 1,
			scaling_time = 50,
--			damage_touch = 1
		},
		paramtype = "light",
		damage_per_second = 1,
		sounds = nodecore.sounds("nc_tree_sticky"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_thorns" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble thorny basket",
		action = "stackapply",
		indexkeys = {"nc_woodwork:form"},
		wield = {name = "wc_naturae:thornbriar_loose"},
		consumewield = 8,
		nodes = {
			{
				match = {name = "nc_woodwork:form", empty = true},
				replace = modname .. ":shelf_thorns"
			},
		}
	})
