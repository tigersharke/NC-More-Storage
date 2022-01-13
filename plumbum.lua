-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_optics_glass_edges.png^[colorize:plum:100^(nc_lode_annealed.png^[mask:nc_optics_tank_mask.png)"

local plum = "(nc_optics_glass_glare.png^[colorize:plum:100)^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_plum", {
		description = "Plum Glass Case",
		tiles = {plum, plum, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 2,
			totable = 1,
			scaling_time = 50,
			silica = 1,
			silica_clear = 1,
			lux_absorb = 50,
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_plum" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble plum glass case",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "wc_plumbum:glass"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_plum"
			},
		}
	})
