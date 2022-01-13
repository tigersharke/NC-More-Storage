-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local frost = "nc_optics_glass_frost.png^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_frost", {
		description = "Chromatic Cauldron",
		tiles = {frost, frost, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 2,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_frost" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble chromatic cauldron",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_optics:glass_opaque"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_frost"
			},
		}
	})
