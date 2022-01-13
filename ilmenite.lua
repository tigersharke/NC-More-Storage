-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local ilmenite = "block_ilmenite.png^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_ilmenite", {
		description = "Ilmenite Cauldron",
		tiles = {ilmenite, ilmenite, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 3,
			totable = 1,
			scaling_time = 50,
			lux_absorb = 20,
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_luxgate_ilmenite"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_ilmenite" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble ilmenite cauldron",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_luxgate:block_ilmenite"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_ilmenite"
			},
		}
	})
