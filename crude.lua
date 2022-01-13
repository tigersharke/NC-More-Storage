-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local bark = "nc_optics_glass_edges.png^(nc_tree_tree_side.png^[mask:nc_optics_tank_mask.png)"

local frost = "nc_optics_glass_crude.png^(" .. bark .. ")"

minetest.register_node(modname .. ":shelf_crude", {
		description = "Crude Case",
--		tiles = {bark, wick},
		tiles = {frost, frost, bark},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 2,
			visinv = 1,
			flammable = 2,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_crude" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble crude case",
		action = "stackapply",
		indexkeys = {"nc_woodwork:form"},
		wield = {name = "nc_optics:glass_crude"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_woodwork:form", empty = true},
				replace = modname .. ":shelf_crude"
			},
		}
	})
