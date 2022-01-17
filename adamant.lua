-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local grate = "nc_lode_annealed.png^[mask:nc_lode_shelf_base.png"

local adamant = "wc_adamant.png^(" .. form .. ")"

local lambent = "wc_adamant.png^((nc_lux_base.png^[mask:nc_lode_mask_molten.png)^[opacity:75)^(" .. form .. ")"

local bottom = "wc_adamant.png^(nc_lux_base.png^[opacity:75)^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_adamant", {
		description = "Adamant Shelf",
		tiles = {form, adamant, grate},
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
		storebox_access = function(pt) return pt.above.y == pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_adamant" then
				return nodecore.stack_get(pos)
			end
		end
	})
	
minetest.register_node(modname .. ":shelf_adamant_cauldron", {
		description = "Adamant Cauldron",
		tiles = {adamant, adamant, form},
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
			if minetest.get_node(pos).name == modname .. ":shelf_adamant_cauldron" then
				return nodecore.stack_get(pos)
			end
		end
	})


minetest.register_node(modname .. ":shelf_adamant_lux", {
		description = "Lambent Adamant Cauldron",
		tiles = {lambent, bottom, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 5,
			visinv = 1,
			storebox = 4,
			totable = 1,
			scaling_time = 50,
			lux_emit = 1
		},
		paramtype = "light",
		light_source = 4,
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_adamant_lux" then
				return nodecore.stack_get(pos)
			end
		end
	})

minetest.register_node(modname .. ":luxlamp", {
		description = "Adamant Luxlamp",
		tiles = {bottom},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 5,
			totable = 1,
			scaling_time = 50,
			lux_emit = 10
		},
		paramtype = "light",
		light_source = 16,
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":luxlamp" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble adamant shelf",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "wc_adamant:shard"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_adamant"
			},
		}
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
				replace = modname .. ":shelf_adamant_cauldron"
			},
		}
	})

nodecore.register_craft({
		label = "assemble lambent cauldron",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "wc_adamant:block_infused"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_adamant_lux"
			},
		}
	})

nodecore.register_craft({
		label = "assemble adamant luxlamp",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_adamant_lux"},
		wield = {name = "nc_optics:prism"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_adamant_lux", empty = true},
				replace = modname .. ":luxlamp"
			},
		}
	})
