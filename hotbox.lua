-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local pum = "nc_igneous_pumice.png^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_pumice", {
		description = "Pumice Cauldron",

		tiles = {pum, pum, form},
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
			if minetest.get_node(pos).name == modname .. ":shelf_pumice" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble hotbox",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_igneous:pumice"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_pumice"
			},
		}
	})
