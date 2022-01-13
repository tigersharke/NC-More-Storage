-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local side = "nc_lode_annealed.png^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_cauldron_annealed", {
		description = "Annealed Lode Cauldron",
		tiles = {side, side, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			lode_cube = 1,
			storebox = 2,
			totable = 1,
			scaling_time = 50,
			lode_temper_annealed = 1,
			metallic = 1,
			lode_cauldron = 1
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_lode_annealed"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_cauldron_annealed" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble cauldron",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_lode:block_annealed"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_cauldron_annealed"
			},
		}
	})
