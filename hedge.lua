-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"

local hedge = "wc_naturae_shrub.png^(" .. form .. ")"

minetest.register_node(modname .. ":hedge", {
		description = "Box Hedge",
		drawtype = "allfaces_optional",
		tiles = {hedge},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 3,
			fire_fuel = 3,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_sticky"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":hedge" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "box hedge",
		action = "stackapply",
		indexkeys = {"nc_woodwork:form"},
		wield = {name = "wc_naturae:shrub_loose"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_woodwork:form", empty = true},
				replace = modname .. ":hedge"
			},
		}
	})
