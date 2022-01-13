-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local frost = "wc_adamant.png^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_adamant", {
		description = "Adamant Cauldron",
		tiles = {frost, frost, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 5,
			visinv = 1,
			storebox = 4,
			totable = 1,
			scaling_time = 50,
			lux_absorb = 10
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_adamant" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble adamant cauldron",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "wc_adamant:block"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_adamant"
			},
		}
	})
